class RSpecChecker

  attr_reader :clone_url, :user_name, :rspec_output

  def initialize(clone_url)
    @clone_url = clone_url
    @user_name = parse_username
  end

  def run
    self.clone_repo
    self.execute_rspec
    self.parse_rspec_output
  end

  def parse_username
    self.clone_url.match(/https?:\/\/github.com\/([^\/]+)/)[1]
  end

  def clone_repo
    FileUtils.remove_dir("tmp/") if File.exists?("tmp/")
    FileUtils.mkdir_p("tmp")
    Git.clone(self.clone_url, "tmp/#{self.user_name}", :path => './')
  end

  def execute_rspec
    config = RSpec.configuration
    json_formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output)
    reporter =  RSpec::Core::Reporter.new(json_formatter)
    config.instance_variable_set(:@reporter, reporter)
    FileUtils.cd("tmp/#{self.user_name}")
    system('bundle install')
    RSpec::Core::Runner.run(["./"])
    FileUtils.cd("../..")
    FileUtils.remove_dir("tmp/")
    @rspec_output = json_formatter.output_hash
  end
  
  def parse_rspec_output
    {
     :examples => @rspec_output[:summary][:example_count],
     :passes => @rspec_output[:summary][:example_count] - @rspec_output[:summary][:failure_count],
     :pendings => @rspec_output[:summary][:pending_count],
     :failures => @rspec_output[:summary][:failure_count],
     :failure_descriptions => @rspec_output[:examples].select do |example|
        example[:status] == 'failed'
      end.map {|ex| ex[:full_description]}.join(";\n")
    } 
  end

  def check_coverage
  end

end