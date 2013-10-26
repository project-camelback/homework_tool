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
    FileUtils.mkdir_p(TempDirectory)
    Git.clone(self.clone_url, "#{TempDirectory}/#{self.user_name}", :path => './')
  end

  def execute_rspec
    # FileUtils.cd("#{TempDirectory}/#{self.user_name}")
    # puts  RSpec::Core::Runner.autorun
    # FileUtils.cd("../..")
  end
  
  def parse_rspec_output
  end

  def check_coverage
  end

end