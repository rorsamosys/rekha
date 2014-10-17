# This migration comes from spree_product_like (originally 20140217160104)
class AddUserToLikes < ActiveRecord::Migration
  def change
    add_column :spree_likes, :user_id, :integer
  end
end
