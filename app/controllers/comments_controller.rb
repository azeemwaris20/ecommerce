class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  load_and_authorize_resource param_method: :comment_params

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(comment_params)
    authorize! :create, @comment
  end

  def update
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    authorize! :update, @comment
  end

  def destroy
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    authorize! :destroy, @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body).tap do |param|
      param[:user_id] = current_user.id
    end
  end

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end
end
