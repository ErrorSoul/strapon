class AddKeywordsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :keywords, :text
  end
end
