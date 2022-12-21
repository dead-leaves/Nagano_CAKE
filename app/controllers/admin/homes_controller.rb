class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.page(params[:page])
  end
  
  private

    def order_params
    params.require(:order).permit( :payment_method, :customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :status )
    end
end
