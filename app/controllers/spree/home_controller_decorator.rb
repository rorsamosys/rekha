module Spree
  HomeController.class_eval do


    
    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end
    def contact_us
    end

    def compare_product
    	@taxonomies = Spree::Taxonomy.all
    	@brands = Spree::Taxon.where("taxonomy_id = ?", 2 )
    	@products = Spree::Product.all
		end

    def find_matched
    	@texon = Spree::Taxon.where("id = ?", params[:taxon] )
    	@texon1 = Spree::Taxon.where("id = ?", params[:texon1] )
    	@product = Spree::Product.where("name ILIKE = ?", params[:product])
    	@product1 = Spree::Product.where("name ILIKE = ?", params[:product1])
    end

    def find_texons
      @texon = Spree::Taxon.where("taxonomy_id = ?", params[:texonomy_id] )
      render :partial =>  'spree/home/find_brand'
    end

    def contact_info
    end
    def about_us
    end  

    def find_products
    end

    def listing_product
      @taxons = Spree::Taxon.where("id IN(?)", params[:taxon]) 
    end
  end
end
