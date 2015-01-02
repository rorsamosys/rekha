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
      @products = Spree::Product.joins("JOIN spree_products_taxons on spree_products_taxons.product_id = spree_products.id
                      JOIN spree_taxons on spree_products_taxons.taxon_id = spree_taxons.id")
              .where("spree_products_taxons.taxon_id IN(?)", params[:taxon_ids])

      products = @products.collect{|p|p.id}
     
      arr1 = params[:first]
      arr2 = params[:second]
      conditions = []
      unless arr1.blank?
        arr1.each_with_index do |price, index|
          if arr2[index].to_i != 0
            conditions << "(spree_prices.amount BETWEEN #{price.to_i} AND #{arr2[index].to_i} AND spree_prices.currency = 'USD')"
          else
            conditions << "(spree_prices.amount > #{price.to_i} AND spree_prices.currency = 'USD')"
          end
        end
      end
      if conditions.blank?
        if not products.blank?
          @filtered_products = Spree::Product.where("id IN(?)", products)
        else
          @filtered_products = Spree::Product.all
        end
      else
        if not products.blank?
          @filtered_products = Spree::Product.where("spree_products.id IN(?) AND #{conditions.join(' OR ')}", products)
          .joins("INNER JOIN spree_variants ON spree_variants.product_id = spree_products.id
                  INNER JOIN spree_prices ON spree_prices.variant_id = spree_variants.id").distinct
        else
          @filtered_products = Spree::Product.where("#{conditions.join(' OR ')}")
          .joins("INNER JOIN spree_variants ON spree_variants.product_id = spree_products.id
                  INNER JOIN spree_prices ON spree_prices.variant_id = spree_variants.id").distinct
        end
      end
      
    end
  end
end
