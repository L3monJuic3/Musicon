class Lesson < ApplicationRecord
  belongs_to :user

  def self.lesson_duration
    " minutes"
  end
end
