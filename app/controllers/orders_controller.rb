class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:update]

  def index
    @orders = Order.paginate(page: params[:page])
  end

  def create
    order = Order.create(user_id: current_user.id)
    current_user.carts.each do |item|
      total_price = item.product.price * item.quantity
      op = order.order_products.create(product_id: item.id, quantity: item.quantity, total_price: total_price)
    end

    if order.save
      flash[:success] = "Your order has been submitted. Please wait for an admin to approve it."
      Cart.delete(current_user.carts.pluck(:id))
      redirect_to products_path
    else
      flash[:danger] = "There something wrong with your order."
      redirect_to products_path
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params) && current_user.admin?
      flash[:success] = "Order was successfully approved."
      redirect_to orders_path
    else
      flash[:danger] = "Order had something wrong."
      redirect_to orders_path
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    flash[:success] = "Order was successfully deleted."
    redirect_to orders_path
  end

  private
  # Strong parameters
  def order_params
    params.require(:order).permit(:user_id, :status, :approved_by_admin_id)
  end
end
