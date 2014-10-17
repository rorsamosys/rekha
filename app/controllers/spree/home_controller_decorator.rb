module Spree
  HomeController.class_eval do

    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end

    def contact_us
    end

    def index
      debugger
      slider = Spree::Taxon.where(:name => 'Slider').first
      @slider_products = slider.products.active if slider

      featured = Spree::Taxon.where(:name => 'Featured').first
      @featured_products = featured.products.active if featured

      latest = Spree::Taxon.where(:name => 'Latest').first
      @latest_products = latest.products.active if latest
    end
      
    def compare_product
    	@taxonomies = Spree::Taxonomy.all
    	@brands = Spree::Taxon.where("taxonomy_id = ?", 2 )
    	@products = Spree::Product.all
		end

    def find_matched
      @taxon = Spree::Taxon.where("id = ?", params[:taxon_id] )
      @taxon2 = Spree::Taxon.where("id = ?", params[:taxon_id2] )
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
      # taxon_ids = params[:taxon].map(&:to_i).reject { |n| n == 0 }
      # @searcher = build_searcher(params.merge(:taxon => taxon_ids))
      # @products = @searcher.retrieve_products
      @taxons = Spree::Taxon.where("id IN(?)", params[:taxon])
    end
  end
end
