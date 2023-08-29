class LessonOrder < ApplicationRecord
  attr_accessor :custom_hidden_field

  belongs_to :user
  belongs_to :lesson



  # validate :validate_custom_hidden_field

  # def self.validate_custom_hidden_field(custom_hidden_field)
  #   # errors.add("custom_hidden_field", "is not valid") unless Lesson.exists?(duration: custom_hidden_field)
  # end

end
