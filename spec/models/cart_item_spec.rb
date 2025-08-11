# spec/models/cart_item_spec.rb
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe '#promo' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:promo) { create(:promo, code: 'PROMO123') }

    context 'when promo_code matches a Promo' do
      let(:cart_item) { create(:cart_item, cart: cart, product: product, promo_code: promo.code) }

      it 'returns the correct promo' do
        expect(cart_item.promo).to eq(promo)
      end
    end

    context 'when promo_code is nil' do
      let(:cart_item) { create(:cart_item, cart: cart, product: product, promo_code: nil) }

      it 'returns nil' do
        expect(cart_item.promo).to be_nil
      end
    end

    context 'when promo_code does not match any Promo' do
      let(:cart_item) { create(:cart_item, cart: cart, product: product, promo_code: 'INVALID') }

      it 'returns nil' do
        expect(cart_item.promo).to be_nil
      end
    end
  end

  describe 'delegated methods' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:promo) { create(:promo, code: 'PROMO123', discount_value: 50, description: 'Test promo') }

    context 'when promo exists' do
      let(:cart_item) { create(:cart_item, cart: cart, product: product, promo_code: promo.code) }

      it 'delegates discount_value to promo' do
        expect(cart_item.discount_value).to eq(50)
      end

      it 'delegates description to promo' do
        expect(cart_item.description).to eq('Test promo')
      end
    end

    context 'when promo does not exist' do
      let(:cart_item) { create(:cart_item, cart: cart, product: product, promo_code: 'INVALID') }

      it 'returns nil for discount_value' do
        expect(cart_item.discount_value).to be_nil
      end

      it 'returns nil for description' do
        expect(cart_item.description).to be_nil
      end
    end
  end
end
