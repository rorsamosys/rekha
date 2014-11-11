module Spree
  ProductsController.class_eval do


    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'

    respond_to :html

    def check_avalability
      @stock_count = Spree::StockLocation.where('zipcode = ? ', params[:zipcode]).count 
    end
  end
end
