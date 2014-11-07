class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :spree_product_reviews do |t|
      t.text :body
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
