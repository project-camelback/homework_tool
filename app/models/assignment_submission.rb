class AssignmentSubmission < Sequel::Model

  many_to_one :assignment
  many_to_one :student

  def evaluate
    t = RSpecChecker.new(self.url)
    self.update(t.run)
  end

  def self.evaluate_all(assignment)
    assignment.assignment_submissions.each do |assn|
      fork {assn.evaluate}
    end
  end

end