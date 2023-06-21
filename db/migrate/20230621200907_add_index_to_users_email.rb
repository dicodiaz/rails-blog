class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def up
    add_index :users, :email, unique: true
  end
end
