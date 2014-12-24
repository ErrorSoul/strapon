class AddDefaultInChild < ActiveRecord::Migration
  def up
    change_column :posts, :child, :integer, default: 0
    change_column :comments, :child, :integer, default: 0
  end

  def down
    change_column :posts, :child, :integer, default: nil
     change_column :comments, :child, :integer, default: nil
  end
end
