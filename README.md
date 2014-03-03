A script for "exporting" data out of gitorious.

The approach is to load this script into the context of the gitorious app.

So:

I'll assume you have this cloned somewhere like this: `~/gitorious-export`

1. `sudo script/console production`
1. `load '~/gitorious-export/export.rb'`

Now you've got an export of your gitorious sitting in `~/gitorious-export/output`
