class Category < ActiveRecord::Base 
  has_many :subcategories, dependent: :destroy
  has_many :products, as: :category, dependent: :restrict_with_error

  before_destroy :check_subcategories

  validates :name, presence: true
  validates :name, uniqueness: {
    case_sensitive: false
  }, unless: Proc.new { |c| c.name.blank? }

  private
    def check_subcategories
      subcategories.each do |subcategory|
        if subcategory.count > 0
          errors.add(:base, "This category cannot be deleted!!!")
          return false
        end
      end
    end
end
