class Rating < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  # validates :product_id, uniqueness: { scope: :user_id,
  #   message: "one product can have only one rating from a single user."
  # }
end
