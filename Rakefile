task :default => [:cli]

task :cli do
  require_relative 'config/environment'
  HomeworkToolCLI.new.run
end

namespace :db do
  task :reload do
    puts "Deleting development database."
    `rm -fr db/*.db`
    puts "Migrating development database."
    `ruby db/migrate.rb development`
    puts "Loading seed data."
    `sqlite3 db/homework_tool_development.db < db/seed.txt`
  end
end