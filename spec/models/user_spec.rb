require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:user) { User.new(email: "test@email.com", password: "123456", phone_number: "07397282826", date_of_birth: Date.new) }
  let(:user) { FactoryBot.create(:user, :phone_number) }
  let(:user_admin) { FactoryBot.create(:user, :admin, :phone_number) }
  let(:user_three) { FactoryBot.create(:user) }

  describe 'validations' do
    it "should have an email present" do
      should validate_presence_of(:email)
    end
    it "should have a unique email" do
      should validate_uniqueness_of(:email).case_insensitive
    end
    it "should have a password" do
      should validate_presence_of(:password)
    end
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

    it "should check administrator privledges" do
      expect(user.is_admin).to eq(nil)
      expect(user_admin.is_admin).to eq(true)
    end
  end

  describe 'associations' do
    it "should have many lessons" do
      should have_many(:lessons)
    end
    it "should have many lesson_orders" do
      should have_many(:lesson_orders)
    end
    it "should have many bookings through lesson_orders" do
      should have_many(:bookings).through(:lesson_orders)
    end
    it "should have many attached videos" do
      should have_many_attached(:videos)
    end
    it "should have many attached photos" do
      should have_many_attached(:photos)
    end
  end
end

# 1. Email confirmation
