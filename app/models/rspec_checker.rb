require 'rspec/core/formatters/json_formatter'
require 'rspec'
require 'rspec/core'
require 'git'
require 'awesome_print'
class RSpecChecker

  attr_reader :clone_url, :user_name

  def initialize(clone_url)
    @clone_url = clone_url
    @user_name = parse_username
  end

  def run
    {
     :passes => 10,
     :fails => 0,
     :coverage => 100
    }
  end

  def parse_username
    self.clone_url.match(/https?:\/\/github.com\/([^\/]+)/)[1]
  end

  def clone_repo
    FileUtils.mkdir_p("tmp")
    Git.clone(self.clone_url, "tmp/#{self.user_name}", :path => './')
  end

  def execute_rspec

    config = RSpec.configuration
    json_formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output)
    reporter =  RSpec::Core::Reporter.new(json_formatter)
    config.instance_variable_set(:@reporter, reporter)
    # RSpec::Core::Runner.run(['my_spec.rb'])
    FileUtils.cd("tmp/#{self.user_name}")
    RSpec::Core::Runner.run(["spec/rps_game_spec.rb"])
    ap json_formatter.output_hash
    FileUtils.cd("../..")
  end
  
  def parse_rspec_output
  end

  def check_coverage
  end

end

t = RSpecChecker.new("https://github.com/manu3569/rps-game-app.git")
t.clone_repo
t.execute_rspec