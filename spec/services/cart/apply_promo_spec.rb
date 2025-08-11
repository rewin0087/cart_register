require 'rails_helper'

RSpec.describe Cart::ApplyPromo do
  let(:product) { Product.create!(name: "Test Product", price: 100, code: "P1") }
  let(:cart) { Cart.create!(session_id: "test_session") }
  let(:cart_item) { CartItem.create!(cart: cart, product: product, quantity: 2, price: product.price * 2) }

  before { cart.cart_items << cart_item }

  context "when promo is discounted_price" do
    let!(:promo) do
      Promo.create!(
        product_code: product.code,
        discount_type: "discounted_price",
        discount_value: 50,
        total_items: [2, -1],
        code: "PROMO1"
      )
    end

    it "applies discounted price promo to cart item" do
      described_class.new(cart).call
      cart_item.reload
      expect(cart_item.price).to eq(100)
      expect(cart_item.promo_code).to eq("PROMO1")
    end
  end

  context "when promo is fixed_amount" do
    let!(:promo) do
      Promo.create!(
        product_code: product.code,
        discount_type: "fixed_amount",
        discount_value: 150,
        total_items: [2],
        code: "PROMO2"
      )
    end

    it "applies fixed amount promo to cart item" do
      cart_item.update(quantity: 3)
      described_class.new(cart).call
      cart_item.reload
      # 3 items: 2 for 150, 1 for 100 = 250
      expect(cart_item.price).to eq(250)
      expect(cart_item.promo_code).to eq("PROMO2")
    end
  end

  context "when no promo applies" do
    it "keeps original price and promo_code blank" do
      described_class.new(cart).call
      cart_item.reload
      expect(cart_item.price).to eq(200)
      expect(cart_item.promo_code).to be_blank
    end
  end

  context "when quantity is less than promo minimum" do
    let!(:promo) do
      Promo.create!(
        product_code: product.code,
        discount_type: "fixed_amount",
        discount_value: 150,
        total_items: [5],
        code: "PROMO4"
      )
    end

    it "does not apply promo if quantity is less than minimum" do
      cart_item.update(quantity: 2)
      described_class.new(cart).call
      cart_item.reload
      expect(cart_item.price).to eq(200)
      expect(cart_item.promo_code).to be_blank
    end
  end

  context "when multiple cart items with different promos" do
    let(:product2) { Product.create!(name: "Second Product", price: 50, code: "P2") }
    let!(:promo1) do
      Promo.create!(
        product_code: product.code,
        discount_type: "discounted_price",
        discount_value: 80,
        total_items: [2, -1],
        code: "PROMO5"
      )
    end
    let!(:promo2) do
      Promo.create!(
        product_code: product2.code,
        discount_type: "fixed_amount",
        discount_value: 90,
        total_items: [2],
        code: "PROMO6"
      )
    end
    let!(:cart_item2) { CartItem.create!(cart: cart, product: product2, quantity: 2, price: product2.price * 2) }

    it "applies correct promos to each cart item" do
      described_class.new(cart).call
      cart_item.reload
      cart_item2.reload
      expect(cart_item.price).to eq(160)
      expect(cart_item.promo_code).to eq("PROMO5")
      expect(cart_item2.price).to eq(90)
      expect(cart_item2.promo_code).to eq("PROMO6")
    end
  end
end
