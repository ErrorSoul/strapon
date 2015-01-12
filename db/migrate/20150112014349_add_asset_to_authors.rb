class AddAssetToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :asset, :string
  end
end
