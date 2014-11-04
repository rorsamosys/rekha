module Spree
	Spree::User.class_eval do
  	has_many :ratings
  	has_many :products
	end
end