class CartsController < ApplicationController

  def index
    @carts = current_user.carts
    @carts.paginate(page: params[:page])
  end

  def create
    if Cart.create_or_update(current_user.id, cart_params[:product_id], cart_params[:quantity])
      flash[:success] = "Product was successfully added to your cart."
      redirect_to carts_path
    else
      flash[:danger] = "There is something wrong. Please try again."
      redirect_to carts_path
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
end
