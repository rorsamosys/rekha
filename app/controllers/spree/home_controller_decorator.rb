module Spree
  HomeController.class_eval do

    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end

    def contact_us
    end

    def index
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
      @taxons = nil
       products = []
      # taxon_ids = params[:taxon].map(&:to_i).reject { |n| n == 0 }
      # @searcher = build_searcher(params.merge(:taxon => taxon_ids))
      # @products = @searcher.retrieve_products

     
      if params["taxon"] and not params["taxon"].blank?
        params["taxon"].each_with_index do |taxon_ids, index|
          @products = Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
                          JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
                  .where("spree_products_taxons.taxon_id IN(?)", taxon_ids[1])
          if index == 0
            products = @products.collect{|p|p.id}
          end
          
          products = products & Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
                          JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
                  .where("spree_products_taxons.taxon_id IN(?)", taxon_ids[1]).collect{|p|p.id}
          
          # if @products
          #   taxon_ids[1].each do |taxon_id|
          #     @products.each do |p|
          #       p.taxons.each do |texon|
          #         products << p.id if texon.id == taxon_id.to_i
          #       end
          #     end
          #   end
          # end
        end
      else
        @products = Spree::Product.all
      end
      
      #if params["taxon"] and not params["taxon"].blank?
        @products = Spree::Product.where("id IN(?)", products) unless products.blank?
      #end
      






        # if @products
        #   @products = @products.reject{|p| p.taxons.id}
        # end
      #@taxons = Spree::Taxon.joins("spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
        #where("spree_products_taxons.taxon_id IN(?)", params[:taxon])
    end
  end
end
