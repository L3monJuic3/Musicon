require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:guest) { create(:guest) }
  let(:admin) { create(:admin) }

  let(:lesson) { build(:lesson) }

  describe "validations" do
    let(:lesson_test) { create(:lesson, name: "Ethan", user: admin) }
    let(:lesson_test_2) { build(:lesson, name: "Ethan", user: admin) }
    let(:lesson_stripe) { create(:lesson, price_cents: 1000) }

    it "should have a name" do
      should validate_presence_of(:name)
    end
    it "should have a description" do
      should validate_presence_of(:description)
    end
    it "should have a price" do
      should validate_presence_of(:price)
    end

    it "should have a duration" do
      should validate_presence_of(:duration)
    end

    it "validates uniqueness of lesson name within the same user" do
      expect(lesson_test).to be_valid
      expect(lesson_test_2).not_to be_valid
    end
  end

  it "monetizes the price" do
    # lesson = FactoryBot.create(:lesson, price_cents: 1000)
    expect(lesson.price).to eq Money.new(1000, "EUR")
  end

  describe 'associations' do
    it "should belong to a user" do
      should belong_to(:user)
    end
    it "should have many slots" do
      should have_many(:slots)
    end
    it "should have many lesson_orders" do
      should have_many(:lesson_orders)
    end
  end
end
