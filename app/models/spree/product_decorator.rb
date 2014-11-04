module Spree
	Spree::Product.class_eval do
	  has_many :ratings
    belongs_to :user	
    add_search_scope :in_all_taxons do |*taxons|
        taxons = get_taxons(taxons)
        id = arel_table[:id]
        joins(:taxons).where(spree_taxons: { id: taxons }).group(id).having(id.count.eq(taxons.size))
    end


    def average_rating
	    ratings.sum(:score) / ratings.count
	  end

	end
end