class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to 'index'
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    render 'index'
  end

  def destroy_all
    cart_items = CartItem.all
    cart_item.destroy_all
    render 'index'
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item] [:item_id] ).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item] [:item_id] )
      cart_item.amount += params[:cart_item] [:amount].to_i
      @cart_item.save
      redirect_to 'index'

    else
      @cart_item.save
      @cart_items = current_customer.cart_items.all
      redirect_to 'index'
    end
  end

  private
  def cart_item_parems
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
