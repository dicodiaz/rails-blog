class AddDefaultToCounters < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :posts_counter, :integer, default: 0, null: false
    change_column :posts, :comments_counter, :integer, default: 0, null: false
    change_column :posts, :likes_counter, :integer, default: 0, null: false
  end

  def down
    # no rollback needed
  end
end
