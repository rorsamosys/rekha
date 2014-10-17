# This migration comes from spree_product_like (originally 20140218094858)
class AddLikesCounterToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :likes_count, :integer, default: 0
  end
end
