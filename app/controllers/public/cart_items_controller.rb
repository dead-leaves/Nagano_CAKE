class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CaerItem.all
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @cart_item = cart_item_parems[:item_id]
    @cart_item.save
    redirect_to cart_items_path
  end
  
  private
  def cart_item_parems
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
