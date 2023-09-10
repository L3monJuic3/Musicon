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
        post lessons_path, params: { lesson: valid_attributes }
        expect(response).to change(Lesson, :count).by(1)
      end

      it "redirects back to the lesson's page" do
        post lessons_path, params: { lesson: valid_attributes }
        expect(response).to redirect_to(lessons_path)
        # expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      let!(:user_guest) { create(:user, :phone_number) }
      let!(:lesson) { create(:lesson, user: user_guest) }

      it "should not allow user without admin privledges to create a lesson" do
        post lessons_path, params: { lesson: lesson }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "GET #edit" do
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:lesson) }

      it "should return a succesful http response" do
        get edit_lesson_path(lesson)
        expect(response).to have_http_status(:success)
      end
    end

    context "when a user does not own the lesson" do
      let(:logged_user) { create(:user, :admin, :phone_number) }
      let(:user2_lesson) { create(:lesson, user: logged_user) }

      it "should not allow access to edit page" do
        get edit_lesson_path(user2_lesson), params: { lesson: user2_lesson }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "PATCH #update" do
    let(:logged_user) { create(:user, :admin, :phone_number) }
    let(:user2_lesson) { create(:lesson, user: logged_user) }
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:lesson) }

      it "redirects back to lesson's page" do
        patch lesson_path(lesson)
        expect(response).to redirect_to(lessons_path)
      end
    end

    context "when a user does not own the lesson" do
      it "should not allow user to update another users lesson" do
        # patch lesson_path(user2_lesson), params: {lesson: { user2_lesson } }
        patch lesson_path(user2_lesson), params: { lesson: { name: "Updated Title" } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid attributes" do
      let(:valid_attributes) { attributes_for(:lesson) }

      it "redirects back to the lesson's page" do
        delete lesson_path(lesson)
        expect(response).to redirect_to(lessons_path)
      end
    end

    context "when a user does not own the lesson" do
      let(:logged_user) { create(:user, :admin, :phone_number) }
      let(:user2_lesson) { create(:lesson, user: logged_user) }

      it "should not delete lesson created by another user" do
        delete lesson_path(user2_lesson)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
