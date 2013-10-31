require 'bundler/setup'
require 'rspec/core'
require 'rspec/core/formatters/json_formatter'
require 'open-uri'

ENV['RACK_ENV'] ||= 'development'

db_path = "#{Dir.pwd}/db/homework_tool_#{ENV['RACK_ENV']}.db"

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

Sequel.connect("sqlite://#{db_path}")

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

require_relative '../app/controllers/application_controller.rb'
require_relative '../app/controllers/student_controller.rb'
 
