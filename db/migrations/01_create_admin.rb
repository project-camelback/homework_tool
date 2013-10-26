Sequel.migration do
  change do
    create_table(:admins) do
      primary_key :id
      String :first_name
      String :last_name
      String :password_hash
      String :email
    end
  end
end
