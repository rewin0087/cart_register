require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items).dependent(:destroy) }
    it { should have_many(:products).through(:cart_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:session_id) }
    it { should validate_uniqueness_of(:session_id) }
  end

  describe '#add_product' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    context 'when cart_item does not exist' do
      it 'creates a new cart_item with quantity 1' do
        expect {
          cart.add_product(product)
        }.to change { cart.cart_items.count }.by(1)
        expect(cart.cart_items.last.quantity).to eq(1)
      end

      it 'creates a new cart_item with given quantity' do
        expect {
          cart.add_product(product, 3)
        }.to change { cart.cart_items.count }.by(1)
        expect(cart.cart_items.last.quantity).to eq(3)
      end
    end

    context 'when cart_item already exists' do
      before { cart.add_product(product, 2) }

      it 'increments quantity by 1 if quantity not given' do
        expect {
          cart.add_product(product)
        }.to change { cart.cart_items.last.quantity }.by(1)
      end

      it 'increments quantity by given amount' do
        expect {
          cart.add_product(product, 4)
        }.to change { cart.cart_items.last.quantity }.by(4)
      end
    end
  end

  describe '#total_price' do
    let(:cart) { create(:cart) }
    let(:product1) { create(:product, price: 50) }
    let(:product2) { create(:product, price: 30) }

    before do
      cart.cart_items.create(product: product1, quantity: 2, price: 100)
      cart.cart_items.create(product: product2, quantity: 1, price: 30)
    end

    it 'returns the sum of cart_item prices' do
      expect(cart.total_price).to eq(130)
    end
  end

  describe '#apply_promo' do
    let(:cart) { create(:cart) }

    it 'calls Cart::ApplyPromo with self' do
      promo_service = instance_double(Cart::ApplyPromo)
      expect(Cart::ApplyPromo).to receive(:new).with(cart).and_return(promo_service)
      expect(promo_service).to receive(:call)
      cart.apply_promo
    end
  end
end
