module Spree
	class Rating < ActiveRecord::Base
	  belongs_to :product
	  belongs_to :user
	end
end	
