class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:update]
  before_action :order_params

  def index
    if params[:status] == "pending"
      @orders = Order.where(status: "pending")
    else
      @orders = Order.all
    end
  end

  def create
    @order = current_user.orders.create
    if @order.save
      flash[:success] = "Your order have been submitted. Please wait for an admin to approve it."
      redirect_to carts_path
    else
      flase[:danger] = "Your order have something wrong. Please check it again."
      redirect_to carts_path
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(:order_params) && current_user.admin?
      @order.approved_by_admin_id = current_user.id
      flash[:success] = "Order was successfully approved."
      redirect_to orders_path
    else
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
    params.(:order).require(:status)
  end
end
