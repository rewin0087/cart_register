class ProductsController < ApplicationController
  def index
    @cart = Cart.find_or_create_by(session_id: session.id.to_s)
    @products = Product.all
  end
end
