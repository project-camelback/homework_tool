require_relative '../spec_helper'

describe AssignmentSubmission do
  
  it { should respond_to(:student) }
  it { should respond_to(:assignment) }

  it { should respond_to(:submission_date) }
  # TODO: original submission, latest submission
  it { should respond_to(:evaluated) }
  it { should respond_to(:passed_tests) }
  it { should respond_to(:failed_tests) }
  it { should respond_to(:teacher_comments) }
  it { should respond_to(:url) }


end