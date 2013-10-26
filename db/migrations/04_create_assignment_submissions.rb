Sequel.migration do
  change do
    create_table(:assignment_submissions) do
      primary_key :id
      foreign_key :student_id, :students
      foreign_key :assignment_id, :assignments
      DateTime :submission_date
      Boolean :evaluated
      Boolean :passed_tests
      Boolean :failed_tests
      String :teacher_comments, :size => 5000
      String :url
    end
  end
end