module Spree
	class ProductReview < ActiveRecord::Base
		belongs_to :product
		
	end
end