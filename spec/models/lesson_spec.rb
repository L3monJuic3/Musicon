require 'rails_helper'

RSpec.describe Lesson, type: :model do
  # let(:user) { User.create(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  # let(:lesson) {Lesson.new(name: "lesson_1", description: "intro_lesson", price: 45.00, duration: 60, user_id: user.id )}
  let(:lesson) { create(:lesson, :user) }
  # let(:user) { create(:user) }
  let(:lesson_2) { create(:lesson, :user, :admin_user)}

  describe "validations" do
    it "should only be able to create a lesson as administrator" do
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
      lesson_two = Lesson.new(name: "lesson_1", user_id: user.id)
      expect(lesson).to be_valid
      expect(lesson_two).not_to be_valid
      expect(lesson_two.errors[:name]).to include('should be unique for each user')
    end

    it "only able to create a lesson if user is administrator" do
      expect(lesson).not_to be_valid
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
