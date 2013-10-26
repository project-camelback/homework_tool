Sequel.migration do
  change do
    create_table(:assignments) do
      primary_key :id
      String   :title
      String   :description, :size => 5000
      DateTime :post_date
      DateTime :due_date
      String   :evaluation_type
    end
  end
end
