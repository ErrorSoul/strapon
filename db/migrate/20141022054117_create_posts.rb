class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :author_id

      t.timestamps
    end
    add_index :posts, [:author_id, :created_at]
  end
end
