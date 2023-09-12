class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :lessons
  has_many :lesson_orders
  has_many :bookings, through: :lesson_orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :email, presence: true
  # validates :email, uniqueness: true

  # validates :password, presence: true
  # validates :password, length: { in: 6..20 }
  # validates :phone_number, format: { with: /\A(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$/,
  #                                    message: "valid uk phone number", multiline: true }

  def self.lesson_orders(user_id)
    LessonOrder.where(user_id: user_id)
  end

  def role?
    is_admin == true
  end
end
