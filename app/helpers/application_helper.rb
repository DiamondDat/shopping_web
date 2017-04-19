module ApplicationHelper
  # Returns the full title on a per-page basis
  def full_title (page_title = '')
    base_title = "Shopping Web"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def carts_price(carts)
    carts.inject(0) { |sum, item| sum + item.product.price * item.quantity }
  end

end
