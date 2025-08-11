require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /" do
    let!(:product) { Product.create!(name: "Test Product", price: 10.0) }
    let(:session) { ActionController::TestSession.new }

    before do
      # Set session id before each request
      allow_any_instance_of(ActionDispatch::Request).to receive(:session)
        .and_return(session)
    end

    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "assigns @products" do
      get root_path
      expect(assigns(:products)).to include(product)
    end

    it "assigns @cart" do
      get root_path
      expect(assigns(:cart)).to be_a(Cart)
      expect(assigns(:cart).session_id).to eq(session.id.to_s)
    end
  end
end
