require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = Product.new
      expect(product).to be_valid
    end
  end

  describe 'database columns' do
    it 'has the expected columns' do
      expect(Product.column_names).to include('id', 'created_at', 'updated_at')
    end
  end
end
