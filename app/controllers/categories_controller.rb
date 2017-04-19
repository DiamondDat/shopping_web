class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user,   only: [:index, :create, :update, :destroy]
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = params[:parent_id] > 0 ? Category.create(category_params)
                                       : Category.sub_categories.create(category_params)
    if @category.save
      flash[:success] = "Your category has been created."
      redirecto_to categories_path
    else
      flash[:danger] = "There are something wrong."
      redirecto_to categories_path
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Your category has been updated."
      redirecto_to categories_path
    else
      flash[:danger] = "Updated category failed."
      redirecto_to categories_path
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category successfully removed."
    redirecto_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, parent_ids: [])
  end
end
