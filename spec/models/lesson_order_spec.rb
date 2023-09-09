require 'rails_helper'

RSpec.describe Lesson_order, type: :model do
  let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:lesson) { Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:lesson_order) { Lesson_order.new(user_id: user.id, lesson_id: lesson.id, discount: 20, package: 20)}

  describe "validations" do
    it { should validate_presence_of(:discount) }
    it { should validate_presence_of(:package) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:lesson) }
    it { should have_many(:bookings) }
  end
end
