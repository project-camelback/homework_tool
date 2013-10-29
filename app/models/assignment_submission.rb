class AssignmentSubmission < Sequel::Model

  many_to_one :assignment
  many_to_one :student

  def evaluate
    t = RSpecChecker.new(self)
    self.update(t.run.merge({:evaluated => true, :evaluation_date => Time.now}))
  end

  def self.evaluate_all(assignment)
    assignment.assignment_submissions.each do |sub|
      system("ruby bin/evaluate.rb #{sub.id}")
    end
  end

end