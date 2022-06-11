class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :search_params, only: [:index]

  def index
    @products = Product.search(@search, page: params[:page] || 1, per_page: 6) if params[:search]
    @products = Product.order(price: :desc).page(params[:page]) unless params[:search]
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    authorize! :create, @product
  end

  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product
  end

  def create
    @serial_no = Product.assign_unique_serial_number
    @product = Product.new(product_params)
    authorize! :create, @product
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    authorize! :update, @product
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @product
    @product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :quantity, images: []).tap do |param|
      param[:user_id] = current_user.id
      param[:serial_no] = @serial_no if @serial_no
    end
  end

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end

  def search_params
    @search = '*' + params[:search] + '*' if params[:search]
  end
end
