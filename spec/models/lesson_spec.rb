require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:lesson) {Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:duration) }

    it "validates uniqueness of lesson name within the same user" do
      lesson_two = Lesson.new(name: "lesson_1", user_id: user.id)
      expect(lesson).to be_valid
      expect(lesson_two).not_to be_valid
      expect(lesson_two.errors[:name]).to include('should be unique for each user')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }

  end
end
