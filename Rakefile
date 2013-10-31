task :default => [:cli]

task :cli do
  require_relative 'config/environment'
  HomeworkToolCLI.new.run
end

namespace :presentation do

  task :save do
    `cp db/homework_tool_development.db db/homework_tool_presentation.db`
    puts "Presentation database saved"
  end

  task :load do
    `cp db/homework_tool_presentation.db db/homework_tool_development.db`
    puts "Loaded presentation database."
  end

end

namespace :db do
  task :reload do
    puts "Deleting development database."
    `rm -fr db/homework_tool_development.db`
    puts "Migrating development database."
    `ruby db/migrate.rb development`
    puts "Loading seed data."
    `sqlite3 db/homework_tool_development.db < db/seed.txt`
  end
end