require 'rails_helper'

RSpec.describe LessonOrder, type: :model do

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
