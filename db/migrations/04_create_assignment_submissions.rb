Sequel.migration do
  change do
    create_table(:assignment_submissions) do
      primary_key :id
      foreign_key :student_id, :students
      foreign_key :assignment_id, :assignments
      DateTime    :evaluation_date
      Boolean     :evaluated, :default => false
      Integer     :passes, :default => 0
      Integer     :pendings, :default => 0
      Integer     :failures, :default => 0
      Integer     :examples, :default => 0
      String      :failure_descriptions, :size => 5000
      String      :teacher_comments, :size => 5000
      String      :url
    end
  end
end