module Spree
	class ProductReview < ActiveRecord::Base
		belongs_to :product
		belongs_to :user	
	end
end