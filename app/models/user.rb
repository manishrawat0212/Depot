class User < ActiveRecord::Base
  include ActiveModel::Dirty

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :line_items, dependent: :destroy

  after_create :send_welcome_mail  
  before_update :user_cannot_be_updated
  before_destroy :user_cannot_be_destroyed
  after_destroy :ensure_an_admin_remains

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }, format: {
    with: /\A[a-z0-9._-]+@[a-z0-9]+\.[a-z]{2,4}\z/i
  }
  has_secure_password
  
  private
    def send_welcome_mail
      WelcomeNewUser.created(self).deliver
    end

    def ensure_an_admin_remains
      if User.count.zero?
        errors.add(:base, "Can't delete last user")
        false
      end
    end

    def user_cannot_be_destroyed
      if email == 'admin@depot.com'
        errors.add(:base, "This user cannot be deleted!!!")
        false
      end
    end

    def user_cannot_be_updated
      if email_was == 'admin@depot.com'
        errors.add(:base, "This user cannot be updated!!!")
        false
      end
    end
end
