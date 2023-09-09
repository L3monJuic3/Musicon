require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:lesson) { Lesson.create(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:slot) { Slot.create(start_time: '08:00:00', end_time: '09:00:00', lesson_id: lesson.id ) }
  let(:booking) { Booking.create(booking_date: '2023-09-10', lesson_order_id: lesson_order.id ) }

  # slots cannot have the same start_time under the same booking_id
  describe "validations" do
    it "should have a start_time" do
      should validate_presence_of(:start_time)
    end
    it "should have a end_time" do
      should validate_presence_of(:end_time)
    end

    it 'validates the uniqueness of start_time per booking_date' do
      slot_2 = Slot.create(start_time: '08:00:00', end_time: '09:00:00', lesson_id: lesson.id )
      expect(slot).to be_valid
      expect(slot_2).not_to be_valid
      expect(slot_2.errors[:start_time]).to include('has already been taken')
    end
  end

  describe "associations" do
    # it { should belong_to(lesson) }
    it "should belong to a lesson" do
      should belong_to(:lesson)
    end
    it "should have many bookings through booking_slots" do
      should have_many(:bookings).through(:booking_slots)
    end
  end
end
