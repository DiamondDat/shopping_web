class ProductsController < ApplicationController
  before_action :admin_user, only: [:create, :update, :destroy]
  before_action :product_params

  def index
    @products = Product.paginate(page: params[:page])
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:success] = "Product was successfully added."
    else
      flash[:danger] = "There is something wrong with your input. Please try again"
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product was successfully updated."
    else
      flash[:danger] = "There is something wrong with your input. Please try again."
      redirect_to products_path
    end
  end

  def destroy
    @product = Product.find(params[:id]).destroy
    flash[:success] = "Product was successfully deleted."
    redirect_to products_path
  end

  private
  # Strong parameter
  def product_params
    params.require(:product).require(:name, :description, :image, :price)
  end
end
