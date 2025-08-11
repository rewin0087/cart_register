class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
    @cart.apply_promo
  rescue ActiveRecord::RecordNotFound
    render html: 'Cart not found', status: :not_found
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
      render html: 'Product not found', status: :not_found
    end
  end
end
