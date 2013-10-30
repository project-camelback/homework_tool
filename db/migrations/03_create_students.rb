Sequel.migration do
  change do
    create_table(:students) do
      primary_key :id
      String   :first_name
      String   :last_name
      String   :email
      String   :password_hash
      String   :github_username
      String   :avatar_url
      String   :semester
    end
  end
end