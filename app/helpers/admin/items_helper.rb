module Admin::ItemsHelper
  def convert_to_taxed(price)
   (price * 1.1).floor
  end
end
