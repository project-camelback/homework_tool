require_relative '../spec_helper'

describe Admin do
  
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:password_hash) }
  it { should respond_to(:email) }

end