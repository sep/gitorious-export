include FileUtils

def get_output_dir(name)
  File.join(File.dirname(__FILE__), name)
end

def get_project_dir(base, project_name)
  File.join(base, project_name)
end

def get_repo_dir(base, project_name, repo_name)
  File.join(get_project_dir(base, project_name), repo_name)
end

def export_projects_data(projects, output_dir)
  hashed = projects.map do |project|

    puts "-" * 80
    puts project.title
    puts project.description
    puts project.slug
    puts "#{project.owner_type} - #{project.owner_id}"

    project.repositories.map do |repo|
      puts 
      puts "  " + repo.name
      puts "  #{repo.owner_type} - #{repo.owner_id}"
      puts "  " + repo.hashed_path
      puts "  " + repo.clone_url
      puts "  " + repo.push_url

      {:name => repo.name, :owner_type => repo.owner_type, :owner_id => repo.owner_id, :clone_url => repo.clone_url}
    end

    {:title => project.title, :owner_type => project.owner_type, :owner_id => project.owner_id, :description => project.description, :slug => project.slug}
  end

  File.open(File.join(output_dir, 'export.json'), 'w'){|f| f.write(hashed.to_json)}
end

def export_projects_source(projects, output_dir)
  projects.each do |project|
    project_dir = get_project_dir(output_dir, project.slug)
    Dir.mkdir(project_dir)

    puts "#{project.title} cloning #{project.repositories.count}"
    project.repositories.each do |repo|
      repo_dir = get_repo_dir(output_dir, project.slug, repo.name)
      Dir.mkdir(repo_dir)
      Dir.chdir(repo_dir) do
          puts "  cloning #{repo.name} (#{repo.clone_url})"
          `git clone #{repo.clone_url}`
      end
    end
  end
end

def export_projects(projects, output_dir)
  export_projects_data(projects, output_dir)
  export_projects_source(projects, output_dir)
end

output_dir = get_output_dir('output')

rm_rf(output_dir) if File.directory?(output_dir)
Dir.mkdir(output_dir)

projects = Project.all.take(2)

export_projects(projects, output_dir)

