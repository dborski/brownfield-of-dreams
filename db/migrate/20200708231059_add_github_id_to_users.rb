class AddGithubIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_id, :bigint
  end
end
