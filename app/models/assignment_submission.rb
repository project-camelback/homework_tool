class AssignmentSubmission < Sequel::Model

  many_to_one :assignment
  many_to_one :student

  def evaluate
    t = RSpecChecker.new(self)
    self.update(t.run.merge({:evaluated => true, :evaluation_date => Time.now}))
  end

  def self.evaluate_all(assignment)
    assignment.assignment_submissions.each do |sub|
      system("ruby bin/evaluate.rb #{sub.id} &> /dev/null &")
    end
  end

  def self.percent_evaluated(assignment)
    total_count = assignment.assignment_submissions.count
    evaluated_count = self.where(:assignment => assignment, :evaluated => true).count
    evaluated_count*100/total_count
  end

end