require 'rails_helper'
require 'date'

RSpec.describe Booking, type: :model do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson) }
  let(:lesson_order) { create(:lesson_order) }
  let(:booking) { create(:booking) }

  describe "validations" do
    it "should have a booking date" do
      should validate_presence_of(:booking_date)
    end
    it "should have a status" do
      should validate_presence_of(:status)
    end
  end

  describe "associations" do
    it "should have many booking slots" do
      should have_many(:booking_slots)
    end
  end

end
