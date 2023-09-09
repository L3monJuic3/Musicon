require 'rails_helper'
require 'date'

RSpec.describe Booking, type: :model do
  let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:lesson) { Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:lesson_order) { LessonOrder.new(user_id: user.id, lesson_id: lesson.id, discount: 20, package: 20)}
  let(:booking) { Booking.new(booking_date: DateTime.new, status: "pending", lesson_order_id: lesson_order.id)}

  describe "validations" do
    it { should validate_presence_of(:booking_date) }
    it { should validate_presence_of(:status) }
  end

  describe "associations" do
    it { should have_many(:booking_slots) }
  end
end
