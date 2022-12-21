class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
  end


  private

    def order_params
    params.require(:order).permit( :payment_method, :customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :status )
    end
end
