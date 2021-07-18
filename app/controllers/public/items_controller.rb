class Public::ItemsController < ApplicationController
  def index
    if params["genre"]
    	@items = Item.active.where(genre_id: params["genre"])
    else
    	@items = Item.active
    end
      # @genres = Genre.active
  end
  
  def show
  end
  
end
