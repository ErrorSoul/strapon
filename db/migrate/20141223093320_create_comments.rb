class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :text
      t.references :post, index: true
      t.string :path
      t.integer :child
      t.integer :class_num

      t.timestamps
    end
    add_index :comments, :path
  end
end
