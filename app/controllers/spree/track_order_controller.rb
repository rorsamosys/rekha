module Spree
  class TrackOrderController < Spree::StoreController
    def find_order
      order = params[:order_number].strip
      @order = Spree::Order.find_by_number(order)
      @ship_state = Spree::Shipment.find_by_order_id(@order.id)
      @payment = Spree::Payment.find_by_order_id(@order.id)
    end

  end
end