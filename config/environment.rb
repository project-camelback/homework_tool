require 'bundler/setup'
require 'rspec/core'
require 'rspec/core/formatters/json_formatter'
require 'open-uri'

ENV['RACK_ENV'] ||= 'development'

TempDirectory = "tmp"

db_path = "#{Dir.pwd}/db/homework_tool_#{ENV['RACK_ENV']}.db"

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

DB = Sequel.connect("sqlite://#{db_path}")

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].each {|f| require f}
