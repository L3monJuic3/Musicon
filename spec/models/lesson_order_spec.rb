require 'rails_helper'

RSpec.describe LessonOrder, type: :model do
  let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:lesson) { Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:lesson_order) { LessonOrder.new(user_id: user.id, lesson_id: lesson.id, discount: 20, package: 20)}
  # let(:booking) { Booking.new(date: Date.new, status: "pending", lesson_order_id: lesson_order.id)}
  describe "validations" do
    it "should have a discount" do
      should validate_presence_of(:discount)
    end

    it "should have a lesson package" do
      should validate_presence_of(:package)
    end
  end

  describe "associations" do
    it "should belong to a user" do
      should belong_to(:user)
    end
    it "should belong to a lesson" do
      should belong_to(:lesson)
    end
    it "should have many bookings" do
      should have_many(:bookings)
    end
  end
end
