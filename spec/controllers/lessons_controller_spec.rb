require 'rails_helper'

RSpec.describe LessonsController, type: :request do
  let!(:user) { create(:user, :admin, :phone_number) }
  let!(:user_guest) { create(:user, :phone_number) }

  let!(:lesson) { create(:lesson, user: user) }
  let!(:lesson2) { create(:lesson, user: user) }
  let!(:lesson3) { create(:lesson, user: user_guest) }
  before do
    sign_in user
  end

  describe "GET #index" do
    it "should return a succesful http response" do
      get lessons_path
      expect(response).to have_http_status(:success)
    end

    it "should have @lessons instance variable for all lessons with current user" do
      get lessons_path
      # Bit of a hack to get controller instance but I will take it!
      expect(@controller.instance_variable_get('@lessons').to_a).to eq([lesson, lesson2])
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

  describe "POST #create" do

    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:lesson) }

      it "creates a new lesson" do
        expect {
          post lessons_path, params: { lesson: valid_attributes }
        }.to change(Lesson, :count).by(1)
      end

      it "redirects back to the lesson's page" do
        post lessons_path, params: { lesson: valid_attributes }
        expect(response).to redirect_to(lessons_path)
        # expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      # let(:invalid_lesson) { create(:lesson, price: "55", user: user) }
      let(:invalid_attributes) { attributes_for(:invalid_lesson) }

      it "does not create a new lesson" do
        expect {
          post lessons_path, params: { lesson: invalid_attributes }
        }.not_to change(Lesson, :count)
      end

      it "re-renders the 'new' template" do
        post lessons_path, params: { lesson: invalid_attributes }
        expect(response).to render_template(:new)
        # expect(response.status).to eq(422)
      end
    end

  end

  describe "PATCH #update" do
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:lesson) }

      it "should return a succesful http respone" do
        patch lesson_path(lesson), params: { lesson: lesson }
        expect(response).to have_http_status(:success)
      end

      it "redirects back to lesson's page" do
        patch lessons_path(lesson), params: { lesson: lesson }
        expect(response).to redirect_to(lessons_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid attributes" do

    end
  end
end
