class RemoveCartToUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :cart, index: true
  end
end
