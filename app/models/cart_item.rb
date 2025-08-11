class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  delegate :discount_value, :description, to: :promo, allow_nil: true

  def promo
    @promo ||= Promo.find_by(code: promo_code)
  end
end
