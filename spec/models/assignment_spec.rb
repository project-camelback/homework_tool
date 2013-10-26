require_relative '../spec_helper'

describe Assignment do
  
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:post_date) }
  it { should respond_to(:due_date) }
  it { should respond_to(:evaluation_type) }

end