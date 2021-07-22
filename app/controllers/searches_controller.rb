class SearchesController < ApplicationController
  def search
    @value = params["search"]["value"]
    @datas = search_for(@value)
  end

   private
    def search_for(value)
          Item.where('name LIKE ?', '%'+value+'%')
    end
end
