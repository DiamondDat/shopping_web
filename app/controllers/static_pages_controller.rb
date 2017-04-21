class StaticPagesController < ApplicationController
  def home
    quantity_sql = OrderProduct.select('SUM(order_products.quantity)')
            .where('products.id = order_products.product_id')
            .group(:product_id).to_sql
    @top_products = Product.select('*', "(#{quantity_sql}) as quantity")
                         .order('quantity DESC')
                         .limit(10)
  end

  def about
  end

  def help
  end

  def contact
  end

end
