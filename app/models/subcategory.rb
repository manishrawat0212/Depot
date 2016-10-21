class Subcategory < ActiveRecord::Base  
  belongs_to :category
  has_many :products, as: :category

  validates :name, presence: true
  validates :name, uniqueness: {
    case_sensitive: false,
    scope: :category_id
  }, unless: Proc.new { |c| c.name.blank? }
end
