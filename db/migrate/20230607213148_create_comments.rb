class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.bigint :author_id
      t.bigint :post_id
      t.text :text

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :post_id
    add_foreign_key :comments, :users, column: :author_id
    add_foreign_key :comments, :posts
  end
end
