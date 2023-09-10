class Lesson < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def self.lesson_duration
    " minutes"
  end

  def self.lesson_times
    Lesson.all.pluck(:duration)
  end

  def self.round_price(price)
    number_to_format = "%.2f" % price
    # Add a leading zero if the number is less than 10.
    if price < 10
      number_to_format = "0#{number_to_format}"
    end
    return number_to_format
  end
end
