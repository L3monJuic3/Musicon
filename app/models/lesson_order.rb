class LessonOrder < ApplicationRecord
  attr_accessor :custom_hidden_field

  # belongs_to :user
  belongs_to :lesson
  has_many :bookings

  validates :discount, presence: true
  validates :package, presence: true
  # validate :validate_custom_hidden_field

  # def self.validate_custom_hidden_field(custom_hidden_field)
  #   # errors.add("custom_hidden_field", "is not valid") unless Lesson.exists?(duration: custom_hidden_field)
  # end

  # belongs_to :student, class_name: 'User', foreign_key: 'user_id', inverse_of: :lesson_orders
  # monetize :amount_cents
  def find_username_by_id(user_id)
    User.find(user_id)
  end

  def self.discount_cal(package)
    if package >= 20
      0.80
    elsif package < 20
      0.75
    elsif package <= 10
      0.80
    else
      0.85
    end
  end
end
