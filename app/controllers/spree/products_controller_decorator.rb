module Spree
  ProductsController.class_eval do


    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'

    respond_to :html

  	def show
  	  return unless @product

      @variants = @product.variants_including_master.active(current_currency).includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property)

      if spree_user_signed_in?
        @rating = Spree::Rating.where(product_id: @product.id, user_id: spree_current_user.id).first_or_create 

        unless @rating 
        	@rating = Spree::Rating.create(product_id: @product.id, user_id: spree_current_user.id, score: 0) 
        end
      end
        
      @reviews = @product.product_reviews.count

      referer = request.env['HTTP_REFERER']
      if referer
        begin
          referer_path = URI.parse(request.env['HTTP_REFERER']).path
          # Fix for #2249
        rescue URI::InvalidURIError
          # Do nothing
        else
          if referer_path && referer_path.match(/\/t\/(.*)/)
            @taxon = Spree::Taxon.find_by_permalink($1)
          end
        end
      end  
  	end

    def add_review
      @review = Spree::ProductReview.create(:body => params[:body], :product_id => params[:product_id], :user_id => params[:user_id])
      flash[:review_success] = 'Review Added Successfully'
    end

    def check_avalability
      @stock_count = Spree::StockLocation.where('zipcode = ? ', params[:zipcode]).count 
    end
  end
end
