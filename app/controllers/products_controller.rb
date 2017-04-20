class ProductsController < ApplicationController
  before_action :admin_user,  only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:success] = "Product was successfully added."
      redirect_to products_path
    else
      flash[:danger] = "There is something wrong with your input. Please try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = "Product was successfully updated."
      redirect_to products_path
    else
      flash[:danger] = "There is something wrong with your input. Please try again."
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product was successfully deleted."
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  # Strong parameter
  def product_params
    params.require(:product).permit(:name, :description, :image, :price, category_ids: [])
  end
end
