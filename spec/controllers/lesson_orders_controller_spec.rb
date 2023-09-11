require 'rails_helper'
RSpec.describe LessonOrdersController, type: :request do
  let(:user) { create(:user, :admin, :phone_number) }
  let(:user) = {create(:user) }
  let(:lesson) = {create(:lesson) }
  let(:lesson_order) { create(:lesson_order) }
  # let!(:lesson_order3) { create(:lesson_order, user: user_guest, lesson: lesson) }

  before do
    sign_in user
    # StripeMock.start
  end

  # after do
  #   StripeMock.stop
  # end

  describe "GET #index" do
    let(:valid_attributes) { attributes_for(:lesson_order) }
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

  describe "GET #show" do
    context "with valid credentials" do
      # let(:user) { create(:user, :admin, :phone_number) }
      # let(:lesson) { create(:lesson, user: user) }
      let(:lesson_order) { create(:lesson_order) }

      it "should return a succesful http response" do
        get lesson_order_path(lesson_order)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    context "when user is signed in" do
      let(:user) { create(:user, :phone_number) }
      let(:valid_attributes) { attributes_for(:lesson_order, user: user) }


      it "creates a new lesson order" do
        post lesson_orders_path, params: { lesson_order: valid_attributes }
        expect(response).to change(Lesson, :count).by(1)
      end

      it "redirects to the checkout page if user signed in" do
        post lessons_path, params: { lesson_order: valid_attributes }
        expect(response).to redirect_to(new_lesson_order_payments_path(lesson_order))
      end
    end

    context "when the user is not signed in" do
      # Assuming you have valid attributes for a lesson order
      let!(:valid_attributes) { attributes_for(:lesson_order) }

      # This stub ensures that there isn't a current_user
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      end

      it "redirects to the sign_up page and saves the params in session" do
        # Here, we're making a post request simulating a create lesson order action
        post lesson_orders_path, params: { lesson_order: valid_attributes }

        # Check if the redirection is to the sign-up page
        expect(response).to redirect_to(new_user_registration_path)
      end

      it "should save the guest users order params in session" do
        post lesson_orders_path, params: { lesson_order: valid_attributes }
        # Check if the session contains the intended parameters
        expect(response).to redirect_to(new_user_registration_path)
        expect(session[:lesson_order_params]).to eq(valid_attributes)
      end
    end

    context "when stripe api has valid params" do
      it "creates a new lesson order and redirects to payment", :stripe_mock do
        expect {
          post lesson_orders_path, params: { lesson_id: lesson.id }
        }.to change(LessonOrder, :count).by(1)

        order = LessonOrder.last

        expect(order.lesson).to eq lesson
        expect(order.lesson_sku).to eq lesson.name
        expect(order.amount).to eq lesson.price
        expect(order.state).to eq "pending"
        expect(order.user).to eq user
        expect(response).to redirect_to new_lesson_order_payment_path(order)
      end
    end
  end
end