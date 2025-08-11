class CartsController < ApplicationController
  before_action :find_cart, only: [:show, :add_product]

  def create
    render json: { cart: Cart.create(session_id: request.session_id) }, status: :created
  end

  def show
    render json: { cart: @cart }, status: :ok
  end

  def add_product
    product = Product.find_by(code: params[:product_code])
    if product
      @cart.add_product(product)
      if @cart.save
        render json: { cart: @cart }, status: :ok
      else
        render json: { error: 'Failed to add product to cart' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  private

  def find_cart
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Cart not found' }, status: :not_found
  end
end
