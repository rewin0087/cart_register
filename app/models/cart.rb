class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :session_id, presence: true, uniqueness: true

  def add_product(product)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity += 1
    cart_item.save
  end

  def checkout
    Cart::Checkout.call(self)
  end
end
