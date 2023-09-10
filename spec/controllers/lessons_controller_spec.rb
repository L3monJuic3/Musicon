require 'rails_helper'

RSpec.describe LessonsController, type: :request do
  let!(:user) { create(:user, :admin, :phone_number) }
  let!(:lesson) { create(:lesson, user: user) }
  let!(:lesson2) { create(:lesson, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "should return a succesful http response" do
      get lessons_path
      expect(response).to have_http_status(:success)
    end

    it "should have @lessons instance variable for all lessons" do
      get lessons_path
      # Bit of a hack to get controller instance but I will take it!
      expect(@controller.instance_variable_get('@lessons')).to eq([lesson, lesson2])
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "should return a succesful http response" do
      get lesson_path(lesson)
      expect(response).to have_http_status(:success)
    end

    it "should return a specific instance of lesson" do
      get lesson_path(lesson)
      expect(@controller.instance_variable_get("@lesson")).to eq(lesson)
    end
  end
end
