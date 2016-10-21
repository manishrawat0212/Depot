class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  scope :by_date, ->(from = Date.today, to = Date.today) { 
    where("DATE(created_at) BETWEEN ? AND ?", from, to)
  }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
