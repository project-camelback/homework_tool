class RSpecChecker

  attr_accessor :wrong_branch
  attr_reader :clone_url, :user_name, :rspec_output, :branch, :failed_branch_hash

  def initialize(assignment_submission)
    @clone_url = assignment_submission.url
    @user_name = parse_username
    @branch = assignment_submission.assignment.branch
  end

  def run
    self.clone_repo
    self.execute_rspec
    self.parse_rspec_output
  end

  def wrong_branch?
    self.wrong_branch
  end

  def parse_username
    self.clone_url.match(/https?:\/\/github.com\/([^\/]+)/)[1]
  end

  def clone_repo
    FileUtils.remove_dir("tmp/") if File.exists?("tmp/")
    FileUtils.mkdir_p("tmp")
    g = Git.clone(self.clone_url, "tmp/#{self.user_name}", :path => './')
    begin
      g.checkout(self.branch)
    rescue
      self.wrong_branch = true
      @failed_branch_hash = { :failure_descriptions => "Couldn't find '#{self.branch}' branch. Please resubmit."}
    end
  end

  def execute_rspec
    config = RSpec.configuration
    json_formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output)
    reporter =  RSpec::Core::Reporter.new(json_formatter)
    config.instance_variable_set(:@reporter, reporter)
    FileUtils.cd("tmp/#{self.user_name}")
    if File.exist?("Gemfile")
      system('bundle install > /dev/null')
    end
    RSpec::Core::Runner.run(["./"])
    FileUtils.cd("../..")
    FileUtils.remove_dir("tmp/")
    @rspec_output = json_formatter.output_hash
  end
  
  def parse_rspec_output
    if wrong_branch?
      self.failed_branch_hash
    else
      {
       :examples => @rspec_output[:summary][:example_count],
       :passes => @rspec_output[:summary][:example_count] - @rspec_output[:summary][:failure_count] - @rspec_output[:summary][:pending_count],
       :pendings => @rspec_output[:summary][:pending_count],
       :failures => @rspec_output[:summary][:failure_count],
       :failure_descriptions => @rspec_output[:examples].select do |example|
          example[:status] == 'failed'
        end.map {|ex| ex[:full_description]}.join(";\n")
      }
    end 
  end

  def check_coverage
  end

end