require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.all.first }
  let(:lesson) { Lesson.create(name: "Lesson 1", description: "Intro lesson", price: 45.00, duration: 60, user_id: user.id) }

  describe "GET #index" do
    it "should return a succesful response" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
