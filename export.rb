Project.all.take(2).each do |project|
  puts "-" * 80
  puts project.title
  puts project.description
  puts project.slug
  puts "#{project.owner_type} - #{project.owner_id}"

  project.repositories.each do |repo|
    puts 
    puts "  " + repo.name
    puts "  #{repo.owner_type} - #{repo.owner_id}"
    puts "  " + repo.hashed_path
    puts "  " + repo.clone_url
    puts "  " + repo.push_url
  end
end
