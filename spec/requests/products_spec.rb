require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    let!(:product) { Product.create!(name: "Test Product", price: 10.0) }

    it "returns http success" do
      get products_path
      expect(response).to have_http_status(:success)
    end

    it "assigns @products" do
      get products_path
      expect(assigns(:products)).to include(product)
    end

    it "assigns @cart" do
      get products_path
      expect(assigns(:cart)).to be_a(Cart)
    end
  end
end
