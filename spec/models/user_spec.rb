require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }

    it "validates password length" do
      user.password = "12345"
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    it "validate uk phone number" do
      expect(user).to be_valid
    end

    it "validates birth date is a kind of date" do
      expect(user.date_of_birth).to be_a(Date)
    end

    it "validates is_subcribed defaults to false or nil" do
      # valid_is_subscribed = [nil, false
      expect(user.subscribed).to user.subscribed.nil? ? eq(nil) : eq(false)
    end
  end
  describe 'associations' do
    it { should have_many(:lessons) }
    it { should have_many(:lesson_orders) }
    it { should have_many(:bookings).through(:lesson_orders) }
    it { should have_many_attached(:videos) }
    it { should have_many_attached(:photos) }
  end
end

# 1. Email confirmation
