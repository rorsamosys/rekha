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
    	@product = Spree::Product.where("id = ?", params[:product_id])
    	@product1 = Spree::Product.where("id = ?", params[:product_sec]) 
      render :partial =>  'spree/home/matched_products'
    end

    def find_texons
      @texon = Spree::Taxon.where("taxonomy_id = ?", params[:texonomy_id] )
      render :partial =>  'spree/home/find_brand'
    end

    def find_2_texons
      @texon = Spree::Taxon.where("taxonomy_id = ?", params[:texonomy_id1] )
      render :partial =>  'spree/home/find_2_brand'
    end

    def find_2_products
      taxon = Spree::Taxon.find(params[:texon_id])
      @products = taxon.products.ransack(params[:q]).result
      @products = @products.page(params[:page]).per(500 || params[:per_page])
      render :partial =>  'spree/home/find_2_products'
    end

    def contact_info
    end

    def about_us
    end  

    def find_products
      taxon = Spree::Taxon.find(params[:texon_id])
      @products = taxon.products.ransack(params[:q]).result
      @products = @products.page(params[:page]).per(500 || params[:per_page])
      render :partial =>  'spree/home/find_products'
    end

    def listing_product
      @taxons = Spree::Taxon.where("id IN(?)", params[:taxon]) 
    end
  end
end
