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
      product_ids = []
       if !params[:product_ids].blank?
        params[:product_ids].each do |id|
          product_ids << id[:p_id]
        end
        @main_product = Spree::Product.where("id = ?", params[:main_product_id])
        product_ids= product_ids.reject(&:blank?)
        @products = Spree::Product.where("id IN(?)", product_ids)
        @product_properties = Spree::ProductProperty.where('product_id IN(?)', product_ids)

      else 
    	  @taxonomies = Spree::Taxonomy.all
      end
		end

    def find_matched
      @taxon = Spree::Taxon.where("id = ?", params[:taxon_id] )
      @taxon2 = Spree::Taxon.where("id = ?", params[:taxon_id2] )
    	@product = Spree::Product.where("id = ?", params[:product_id])
    	@product1 = Spree::Product.where("id = ?", params[:product_sec])
      @product_properties1 = Spree::ProductProperty.where('product_id = ?', params[:product_id])
      @product_properties2 = Spree::ProductProperty.where('product_id = ?', params[:product_sec])
      
      render :partial =>  'spree/home/matched_products'
    end

    def find_texons
      @texon = Spree::Taxon.where("taxonomy_id = ?", params[:texonomy_id] )
      render :partial =>  'spree/home/find_brand'
      #render :json => {:texon =>  @texon} 
    end

    def find_2_texons
      @texon = Spree::Taxon.where("taxonomy_id = ?", params[:texonomy_id1] )
      render :partial =>  'spree/home/find_2_brand'
      #render :json => {:texon =>  @texon} 
    end

    def find_2_products
      taxon = Spree::Taxon.find(params[:texon_id])
      @products = taxon.products.ransack(params[:q]).result
      @products = @products.page(params[:page]).per(500 || params[:per_page])
      render :partial =>  'spree/home/find_2_products'
      #render :json => {:products =>  @products} 
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
      products = [] 

    #params[:taxon_ids].each_with_index do |taxon_id, index|
      @products = Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
                      JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
              .where("spree_products_taxons.taxon_id IN(?)", params[:taxon_ids])
      # if index == 0
        products = @products.collect{|p|p.id}
      # end
      
      # products = products & Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
      #                 JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
      #         .where("spree_products_taxons.taxon_id IN(?)", taxon_id).collect{|p|p.id}
        
       
    #end
    @filtered_products = Spree::Product.where("id IN(?)", products) unless products.blank?



      # product_sec = Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
      #                     JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
      #             .where("spree_products_taxons.taxon_id IN(?)", params[:taxon_ids])
          
      # products = product_sec.collect{|p|p.id}
      # @filtered_products = Spree::Product.where("id IN(?)", products) unless products.blank?
    end
  end
end
