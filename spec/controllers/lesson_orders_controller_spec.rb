require 'rails_helper'
RSpec.describe LessonOrdersController, type: :request do
  let!(:user) { create(:user, :admin, :phone_number) }
  let!(:user_guest) { create(:user, :phone_number) }

  let!(:lesson) { create(:lesson, user: user) }

  let!(:lesson_order) { create(:lesson_order, user: user, lesson: lesson) }
  let!(:lesson_order2) { create(:lesson_order, user: user, lesson: lesson) }
  let!(:lesson_order3) { create(:lesson_order, user: user_guest, lesson: lesson) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "should return a succesful http response" do
      get lesson_orders_path
      expect(response).to have_http_status(:success)
    end

    it "should have @lesson_orders instance variable for all lessons with current user" do
      get lesson_orders_path
      # Bit of a hack to get controller instance but I will take it!
      expect(@controller.instance_variable_get('@lesson_orders').to_a).to eq([lesson_order, lesson_order2])
      expect(response).to have_http_status(:success)
    end
  end
end
