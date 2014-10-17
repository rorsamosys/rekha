# This migration comes from spree_product_like (originally 20140217140001)
class CreateSpreeLikes < ActiveRecord::Migration
  def change
    create_table :spree_likes do |t|
      t.timestamps
    end
  end
end
