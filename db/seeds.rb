# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[
  { name: 'Green Tea', code: 'GR1', price: 3.11 },
  { name: 'Strawberry', code: 'SR1', price: 5.00 },
  { name: 'Coffee', code: 'CF1', price: 11.23 }
].each do |product_attributes|
  Product.find_or_create_by!(product_attributes)
end

[
  {
    code: 'GR1_B1T1',
    description: 'Buy 1 Get 1 Green Tea',
    product_code: 'GR1',
    discount_type: 'fixed_amount',
    discount_value: 3.11,
    total_items: [2]
  },
  {
    code: 'SR1_BUY_3_MORE',
    description: 'Buy 3 or more Strawberry',
    product_code: 'SR1',
    discount_type: 'discounted_price',
    discount_value: 4.50,
    total_items: [3, -1]
  },
  {
    code: 'CF1_BUY_3_MORE',
    description: 'Buy 3 or more Coffee',
    product_code: 'CF1',
    discount_type: 'discounted_price',
    discount_value: 7.49,
    total_items: [3, -1]
  }
].each do |promo_attributes|
  Promo.find_or_create_by!(promo_attributes)
end
