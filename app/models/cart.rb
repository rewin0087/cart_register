class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :session_id, presence: true, uniqueness: true

  def add_product(product, quantity = nil)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id)

    if quantity
      cart_item.quantity += quantity.to_i
    else
      cart_item.quantity += 1
    end

    cart_item.save
  end

  def total_price
    cart_items.sum(:price)
  end

  def item_count
    cart_items.sum(:quantity)
  end

  def apply_promo
    Cart::ApplyPromo.new(self).call
  end
end
