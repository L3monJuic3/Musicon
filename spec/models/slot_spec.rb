require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:user) { create(:user, :phone_number) }
  let(:user_admin) { create(:user, :admin, :phone_number) }

  let(:lesson) { create(:lesson, user: user_admin) }
  # let(:lesson_2) { create(:lesson, user: user) }

  let(:slot) { create(:slot, lesson: lesson) }
  let(:slot_2) { create(:slot, lesson: lesson )}

  describe "validations" do
    it "should have a start_time" do
      should validate_presence_of(:start_time)
    end
    it "should have a end_time" do
      should validate_presence_of(:end_time)
    end

    it 'validates the uniqueness of start_time per booking_date' do
      slot_2 = Slot.create(start_time: '08:00:00', end_time: '09:00:00', lesson_id: lesson.id )
      expect(slot).not_to be_valid
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
