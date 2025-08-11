require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/carts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/carts/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /add_product" do
    it "returns http success" do
      get "/carts/add_product"
      expect(response).to have_http_status(:success)
    end
  end

end
