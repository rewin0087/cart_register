require 'rails_helper'

RSpec.describe Promo, type: :model do
  describe 'enum discount_type' do
    it 'defines the correct enum values' do
      expect(Promo.discount_types).to eq({
        'discounted_price' => 'discounted_price',
        'fixed_amount' => 'fixed_amount'
      })
    end

    it 'allows creation with discounted_price' do
      promo = Promo.new(discount_type: 'discounted_price')
      expect(promo.discount_type).to eq('discounted_price')
    end

    it 'allows creation with fixed_amount' do
      promo = Promo.new(discount_type: 'fixed_amount')
      expect(promo.discount_type).to eq('fixed_amount')
    end

    it 'raises error for invalid discount_type' do
      expect {
        Promo.new(discount_type: 'invalid_type')
      }.to raise_error(ArgumentError)
    end
  end
end
