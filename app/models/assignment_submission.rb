class AssignmentSubmission < Sequel::Model

  many_to_one :assignment
  many_to_one :student

  def evaluate
    t = RSpecChecker.new(self.url)
    t.run
  end

end