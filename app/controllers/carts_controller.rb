class CartsController < ApplicationController
  before_action :correct_user, only: [:create, :destroy, :update]
  before_action :admin_user,   only: :destroy

  def index
    @carts = current_user.carts
    @carts.paginate(page: params[:page])
  end

  def create
    @cart = current_user.carts.create(cart_params)
    if @cart.save
      flash[:success] = "Product was successfully added to your cart."
    else
      flash[:danger] = "There is something wrong. Please try again."
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update_attributes(cart_params)
      redirect_to carts_path
    else
      redirect_to carts_path
    end
  end

  def destroy
    Cart.find(params[:id]).destroy
    flash[:danger] = "Product have been removed from your cart."
    redirect_to carts_path
  end

  private
  # Strong parameters
  def cart_params
    params.require(:cart).permit(:quantity, :product_id)
  end

  # Confirms correct user
  def correct_user
    @cart = current_user.carts.find_by(params[:id])
    redirect_to root_path if @cart.nil?
  end
end
