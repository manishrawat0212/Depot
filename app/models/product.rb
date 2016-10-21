class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /.(gif|jpg|jpeg|png)\Z/i
      record.errors[attribute] << 'must be a URL for GIF, JPG or PNG image.'
    end
  end
end

class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record.price < record.discounted_price
      record.errors[:price] << 'should be greater than discount price'
    end
  end
end

class Product < ActiveRecord::Base
  include ActiveModel::Dirty
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, limit: 3
  
  has_many :ratings, dependent: :destroy
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  belongs_to :category, polymorphic: true
  
  after_create :increment_counters
  after_destroy :decrement_counters
  after_update :adjust_counters
  before_save :assign_default_title, if: :is_title_blank?
  # before_save :set_discount_price, if: :is_discounted_price_blank?
  
  # validates :image_url, presence: true, url: true
  
  validates :permalink, uniqueness: { case_sensitive: false }, format: {
    with: /\A[a-z]+(\-[a-z]+){2,}\z/i,
    message: :invalid
  }
  validates :discounted_price, numericality: true, unless: :is_discounted_price_blank?
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 0.01
  }
  validates :price, numericality: {
    greater_than: :discounted_price
  }, unless: :is_discounted_price_blank?
  validates :category_id, presence: true
  # validate :description_size

  # validates_with PriceValidator, unless: [:is_price_blank?, :is_discounted_price_blank?]

  # validates :images, presence: true

  scope :enabled, -> { where(enabled: true) }

  def self.latest
    Product.order(:updated_at).last
  end

  private
    def description_size
      word_count = description.split.length
      if word_count < 5 || word_count > 10
        errors.add(:description, :invalid)
      end
    end

    def is_title_blank?
      title.blank? ? true : false
    end

    def is_price_blank?
      price.blank? ? true : false
    end

    def is_discounted_price_blank?
      discounted_price.blank? ? true : false
    end

    def assign_default_title
      self.title = 'abc'
    end

    def set_discount_price
      self.discounted_price = price
    end

    def no_images_added(attributes)
      attributes[:url].blank?
    end

    [:increment, :decrement].each do |type|
      define_method("#{type}_counters") do
        category_type.constantize.send("#{type}_counter", :count, category_id)
        if category_type == 'Subcategory'
          'Category'.constantize.send("#{type}_counter", :count, Subcategory.find(category_id).category_id)
        end  
      end
    end

    def adjust_counters
      category_type_was.constantize.send(:decrement_counter, :count, category_id_was)
      if category_type_was == 'Subcategory'
        'Category'.constantize.send(:decrement_counter, :count, Subcategory.find(category_id_was).category_id)
      end
      increment_counters();
    end
end
