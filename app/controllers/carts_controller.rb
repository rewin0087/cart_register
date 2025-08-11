class CartsController < ApplicationController
  before_action :find_cart, only: [:show]

  def show
    @cart.apply_promo
  end

  def add_product
    @cart = Cart.find_or_create_by(session_id: session.id.to_s)
    @product = Product.find_by(id: params[:product_id])

    if @product
      @cart.add_product(@product, params[:quantity])
      respond_to do |format|
        format.turbo_stream
      end
    else
      render text: 'Product not found', status: :not_found
    end
  end

  private

  def find_cart
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render text: 'Cart not found', status: :not_found
  end
end
