require 'rails_helper'

RSpec.describe Lesson, type: :model do
  # let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  # let(:lesson) {Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:user) { create(:user, :phone_number) }
  let(:user_admin) { create(:user, :admin, :phone_number) }

  # let(:lesson) { create(:lesson_no_admin, user: user) }
  let(:lesson_2) { create(:lesson, user: user_admin)}

  let(:lesson_3) {create(:lesson, name: "same", user: user_admin)}
  let(:lesson_4) {create(:lesson, name: "same", user: user_admin)}
  describe "validations" do
    it "should only be able to create a lesson as administrator" do
      lesson = Lesson.new(name: "same", description: "desc", price: 55, duration: 60, user_id: user)
      expect(lesson).not_to be_valid
      expect(lesson_2).to be_valid
    end
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
      user_test = User.create!(  email: "test10@musicon.com", first_name: "ethan", last_name: "lane", password: "123456789",phone_number: "07397282826", is_admin: true, date_of_birth: Date.new)
      lesson_3 = Lesson.create(name: "same", description: "desc", price: 55, duration: 60, user_id: user_test.id)
      lesson_4 = Lesson.create(name: "same", description: "desc", price: 55, duration: 60, user_id: user_test.id)
      expect(lesson_3).to be_valid
      expect(lesson_4).not_to be_valid
      # expect(lesson_4.errors[:name]).to include('should be unique for each user')
    end
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
