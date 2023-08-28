class Lesson < ApplicationRecord
  belongs_to :user

  def self.lesson_duration
    " minutes"
  end

  def self.lesson_times
    # lessons_with_duration.pluck(:duration, :id).map { |duration, id| "#{duration} minutes" }
    Lesson.all.pluck(:duration)
  end
end
