class AddChildToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :child, :integer, :default => 0
  end
end
