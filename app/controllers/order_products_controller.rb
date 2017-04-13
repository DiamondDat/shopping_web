class OrderProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:show, :create, :destroy]


end
