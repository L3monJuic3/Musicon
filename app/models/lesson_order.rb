class LessonOrder < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  accepts_nested_attributes_for :lesson
end
