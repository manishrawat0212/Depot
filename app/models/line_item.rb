class LineItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :product
  belongs_to :cart, counter_cache: :line_item_count

  validates :product_id, uniqueness: { scope: :cart_id,
    message: "one product can be added only once in the cart."
  }, if: :cart_id

  def total_price
    product.price * quantity
  end
end
