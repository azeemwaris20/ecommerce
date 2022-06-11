class WelcomeController < ApplicationController
  def index
    @products = Product.order(created_at: :desc)
  end

  def about; end

  def contact; end
end
