class AssignmentSubmission < Sequel::Model

  many_to_one :assignment
  one_to_one :student

end