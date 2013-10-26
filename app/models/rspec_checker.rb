class RSpecChecker

  def initialize(clone_url)
    @clone_url = clone_url
  end

  def run
    {
     :passes => 10,
     :fails => 0,
     :coverage => 100
    }
  end

  def clone_repo
  end

  def execute_rspec
  end
  
  def parse_rspec_output
  end

  def check_coverage
  end

end