require_relative '../spec_helper'

describe RSpecChecker do
  
  let(:clone_url) { "https://github.com/manu3569/rps-game-app.git" }
  
  let(:return_hash) do
    {
     :passes => 10,
     :fails => 0,
     :coverage => 100
    }
  end
  
  let(:rspec_checker) { RSpecChecker.new(clone_url) }

  subject { rspec_checker }
  
  it { should respond_to(:run) }
  it { should respond_to(:clone_repo) }
  it { should respond_to(:execute_rspec) }
  it { should respond_to(:parse_rspec_output) }
  it { should respond_to(:check_coverage) }

  it "should return a hash" do
    expect(rspec_checker.run).to eq(return_hash)
  end
  
end