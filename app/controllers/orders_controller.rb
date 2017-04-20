class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:update]
  before_action :set_order,  only: [:order_details, :update, :destroy]

  def index
    @orders = Order.paginate(page: params[:page], per_page: 10)
  end

  def order_details
    @order_details = @order.order_products
  end

  def create
    order = Order.create(user_id: current_user.id)
    current_user.carts.each do |item|
      total_price = item.product.price * item.quantity
      order.order_products.create(product_id: item.product_id, quantity: item.quantity, total_price: total_price)
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
    if @order.update_attributes(order_params) && current_user.admin?
      flash[:success] = "Order was successfully approved."
      redirect_to orders_path
    else
      flash[:danger] = "Order had something wrong."
      redirect_to orders_path
    end
  end

  def destroy
    @order.destroy
    flash[:success] = "Order was successfully deleted."
    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  # Strong parameters
  def order_params
    params.require(:order).permit(:user_id, :status, :approved_by_admin_id)
  end
end
