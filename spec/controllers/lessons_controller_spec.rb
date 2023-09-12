require 'rails_helper'

RSpec.describe LessonsController, type: :request do
  let(:admin) { create(:admin) }
  let(:guest) { create(:guest) }

  let(:lesson) { create(:lesson, user: admin) }
  let(:lesson2) { create(:lesson) }
  let(:lesson3) { build(:invalid_lesson) }

  let(:other_lesson) { create(:lesson) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "should return a succesful http response" do
      get lessons_path
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
      it "creates a new lesson" do
        expect {
          post lessons_path, params: { lesson: lesson.attributes }
        }.to change(Lesson, :count).by(1)
        # puts response.body
      end
      it "redirects back to the lesson's page" do
        post lessons_path, params: { lesson: lesson.attributes }
        expect(response).to redirect_to(lessons_path)
        # expect(flash[:notice]).to be_present
      end
    end

    context "with non-admin user" do
      before do
        sign_in guest
      end
      it "does not allow non-admin users to create a lesson" do
        expect {
          post lessons_path, params: { lesson: lesson3.attributes }
        }.not_to change(Lesson, :count)
        # expect(response).to have_http_status(:forbidden) # or whatever your expected response is
      end
    end
  end

  describe "GET #edit" do
    context "with valid attributes" do
      it "should return a succesful http response" do
        get edit_lesson_path(lesson)
        expect(response).to have_http_status(:success)
      end
    end

    context "when a user does not own the lesson" do
      it "should not allow access to edit page" do
        get edit_lesson_path(lesson2)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "redirects back to lesson's page" do
        patch lesson_path(lesson)
        expect(response).to redirect_to(lessons_path)
      end
    end

    context "when a user does not own the lesson" do
      it "should not allow user to update another users lesson" do
        # patch lesson_path(user2_lesson), params: {lesson: { user2_lesson } }
        patch lesson_path(lesson2), params: { lesson: { name: "Updated Title" } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid attributes" do
      it "redirects back to the lesson's page" do
        delete lesson_path(lesson)
        expect(response).to redirect_to(lessons_path)
      end
    end

    context "when a user does not own the lesson" do
      it "should not delete lesson created by another user" do
        delete lesson_path(lesson2)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
