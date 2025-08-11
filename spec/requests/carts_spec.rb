# spec/requests/carts_controller_spec.rb
require 'rails_helper'

RSpec.describe CartsController, type: :request do
  let(:product) { Product.create(name: "Test Product") }
  let(:session) { ActionController::TestSession.new }
  let(:cart) { Cart.create(session_id: session.id) }

  before do
    # Set session id before each request
    allow_any_instance_of(ActionDispatch::Request).to receive(:session)
      .and_return(session)
  end

  describe "GET #show" do
    it "applies promo and returns success for existing cart" do
      allow_any_instance_of(Cart).to receive(:apply_promo)
      get cart_path(cart)
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 for non-existent cart" do
      get cart_path(id: "invalid")
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Cart not found")
    end
  end

  describe "POST #add_product" do
    it "adds product and responds with turbo_stream if product exists" do
      post add_product_carts_path, params: { product_id: product.id, quantity: 2 }, as: :turbo_stream
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 if product does not exist" do
      post add_product_carts_path, params: { product_id: 0, quantity: 1 }, as: :turbo_stream
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Product not found")
    end

    it "creates a new cart if none exists for session" do
      expect {
          post add_product_carts_path, params: { product_id: product.id, quantity: 1 }, as: :turbo_stream
      }.to change { Cart.count }.by(1)
    end

    it "does not create a new cart if one exists for session" do
      cart # create cart
      expect {
          post add_product_carts_path, params: { product_id: product.id, quantity: 1 }, as: :turbo_stream
      }.not_to change { Cart.count }
    end
  end
end
