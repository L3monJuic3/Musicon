class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :password, presence: true
  validates :password, length: { in: 6..20 }

  def self.lesson_orders(user_id)
    LessonOrder.where(user_id: user_id)
  end
end
