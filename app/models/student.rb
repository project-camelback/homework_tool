class Student < Sequel::Model

  one_to_many :assignment_submissions

end