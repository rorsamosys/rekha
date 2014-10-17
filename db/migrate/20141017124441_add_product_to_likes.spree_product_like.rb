# This migration comes from spree_product_like (originally 20140217160053)
class AddProductToLikes < ActiveRecord::Migration
  def change
    add_column :spree_likes, :product_id, :integer

  end
end
