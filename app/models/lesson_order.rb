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

  def find_user_by_id(user_id)
    User.find(user_id).first_name
  end
end
