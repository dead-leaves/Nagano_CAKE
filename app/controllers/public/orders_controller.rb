class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!
 
  def new
   @order = Order.new
   @address = current_customer.address
  end


  def confirm
   @order = Order.new(order_params)

   @cart_items = current_customer.cart_items

   @totel = 0
   @order.shipping_cost = 800


     if params[:order][:select_address] == "1"
     @order.postal_code = current_customer.postal_code
     @order.address = current_customer.address
     @order.name = current_customer.last_name + current_customer.first_name

     elsif params[:order][:select_address] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

     elsif params[:order][:select_address] == "3"
       @order.postal_code = params([:order][:postal_code])
       @order.address = params([:order][:address])
       @order.name = params([:order][:name])
     end
     @order.customer_id = current_customer.id
  end


  def thanks
  end

  def create
   @order = current_customer.orders.new(order_params)
   @customer = current_customer
   @cart_items = current_customer.cart_items.all
   @order.customer_id = current_customer.id

   if @order.save!
    @cart_items.each do |cart_item|

     @order_detail = OrderDetail.new
     @order_detail.item_id = cart_item.item_id
     @order_detail.order_id = @order.id
     @order_detail.price = cart_item.item.price
     @order_detail.amount = cart_item.amount
     @order_detail.making_status = 0
     @order_detail.save!
    end
    @current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
   else
    render :new
   end
  end

  def index
   @orders = current_customer.orders
  end

  def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details
  end

   private

    def order_params
    params.require(:order).permit( :payment_method, :customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :status )
    end

end
