class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
  end

  def about
  end

   private
    def item_params
      params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active )
    end

end
