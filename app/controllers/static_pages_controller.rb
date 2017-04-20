class StaticPagesController < ApplicationController
  def home
    # Get all the products
    @products = Product.all
    # Get top product
    stats = OrderProduct.group(:product_id).sum(:quantity)
    @sorted_stats = stats.sort_by{ |k, v| v }.reverse.first(10).to_h
  end

  def about
  end

  def help
  end

  def contact
  end
end
