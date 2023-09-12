class Lesson < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :slots, dependent: :destroy
  has_many :lesson_orders, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: { scope: :user_id, message: "lesson name must be unique within the same user" }
  validates :description, presence: true
  validates :price, presence: true
  validates :duration, presence: true

  # validate :check_admin

  def self.lesson_duration
    " minutes"
  end

  def self.lesson_times
    Lesson.all.pluck(:duration)
  end

  def self.round_price(price)
    number_to_format = "%.2f" % price
    # Add a leading zero if the number is less than 10.
    price < 10 ? "0#{number_to_format}" : number_to_format
    # if price < 10
    #   number_to_format = "0#{number_to_format}"
    # end
    # return number_to_format
  end

  private

  def check_admin
    unless current_user&.admin?
      flash[:alert] = "Only admin users can perform this action."
      redirect_to root_path # or wherever you want
    end
  end
end
