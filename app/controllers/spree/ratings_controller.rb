module Spree
  class RatingsController  < Spree::StoreController

    def update
      @rating = Spree::Rating.find(params[:id])
      @product = @rating.product
      if @rating.update_attributes(score: params[:score])
        respond_to do |format|
          format.js
        end
      end
    end
  end
end