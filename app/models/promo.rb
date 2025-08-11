class Promo < ApplicationRecord
  enum :discount_type, { discounted_price: 'discounted_price', fixed_amount: 'fixed_amount' }
end
