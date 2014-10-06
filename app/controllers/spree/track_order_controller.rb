module Spree
  class TrackOrderController < Spree::StoreController
    def find_order
      @order = Spree::Order.find_by_number(params[:order_number])
    end

  end
end