class Image < ActiveRecord::Base
  belongs_to :product
  
  # validates :url, presence: true
end
