class Cart::ApplyPromo
  def initialize(cart)
    @cart = cart
  end

  def call
    cart.tap do |cart|
      @cart.cart_items.each do |item|
        product = item.product
        promo = Promo.find_by(product_code: product.code)

        apply_promo(promo, item) if promo
        item.reload
        item.update(price: product.price * item.quantity) if item.promo_code.blank?
      end
    end.reload
  end

  private

  attr_reader :cart

  def apply_promo(promo, item)
    case promo.discount_type
    when 'discounted_price'
      min_item, max_item = promo.total_items.map(&:to_i)
      discounted_price = promo.discount_value

      if item.quantity >= min_item && max_item == -1
        item.update(price: promo.discount_value * item.quantity, promo_code: promo.code)
      end
    when 'fixed_amount'
      min_item = promo.total_items.first.to_i

      if item.quantity >= min_item
        discounted_item_count = item.quantity / min_item
        original_item_count = item.quantity % min_item

        discounted_price = (discounted_item_count * promo.discount_value) + (original_item_count * item.product.price)
        item.update(price: discounted_price, promo_code: promo.code)
      end
    else
      raise "Unknown discount type: #{promo.discount_type}"
    end
  end
end
