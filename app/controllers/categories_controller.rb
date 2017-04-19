class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user,   only: [:index, :create, :update, :destroy]
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    category      = Category.find(params[:category_id])
    @sub_category = category.sub_categories.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = "Your category has been created."
      redirect_to categories_path
    else
      flash[:danger] = "There are something wrong."
      redirect_to categories_path
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Your category has been updated."
      redirect_to categories_path
    else
      flash[:danger] = "Updated category failed."
      redirect_to categories_path
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category successfully removed."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, parent_ids: [])
  end
end
