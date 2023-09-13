require 'rails_helper'
require 'stripe_mock'
RSpec.describe LessonOrdersController, type: :request do
  let(:admin) { create(:admin) }
  let(:guest) { create(:guest) }

  let!(:lesson) { create(:lesson, user: admin) }
  let(:lesson_order) { create(:lesson_order, user_id: guest.id, lesson: lesson) }

  let(:lesson_order_2) { build(:lesson_order)}

  before do
    sign_in guest
    StripeMock.start
  end

  after do
    StripeMock.stop
  end

  describe "GET #index" do
    it "should return a succesful http response" do
      get lesson_orders_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    context "with valid credentials" do
      it "should return a succesful http response" do
        get lesson_order_path(lesson_order)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #create" do
    context "when user is signed in" do
      it "creates a new lesson order" do
        expect { post lesson_orders_path, params: { lesson_order: lesson_order.attributes, lesson: lesson.attributes, user: guest.attributes, } }.to change(LessonOrder, :count).by(1)
      end

      it "redirects to the checkout page if user signed in" do
        post lesson_orders_path, params: { lesson_order: lesson_order.attributes }
        expect(response).to redirect_to(new_lesson_order_payments_path(lesson_order))
      end
    end

    context "when the user is not signed in" do
      before do
        sign_out guest
      end

      it "redirects to the sign_up page and saves the params in session" do
        # Here, we're making a post request simulating a create lesson order action
        post lesson_orders_path, params: { lesson_order: lesson_order.attributes }
        # Check if the redirection is to the sign-up page
        expect(response).to redirect_to(new_user_registration_path)
      end

      it "should save the guest users order params in session" do
        post lesson_orders_path, params: { lesson_order: lesson_order.attributes }
        # Check if the session contains the intended parameters
        expect(session[:lesson_order_params]).to eq(lesson_order.attributes)
        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end


  context "stripe API" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:stripe_product) { stripe_helper.create_product(name: "My Product",
      price: 1000,
      description: "This is a test product") }


    describe "POST #checkout" do
      it "creates a Stripe product" do
        # stripe_product = stripe_product(params[:name] = "Ethan")
        expect(stripe_product).not_to be_nil
      end

      it "creates a Stripe price" do
        stripe_price = Stripe::Price.create(product: stripe_product.id, unit_amount: lesson_order.amount, currency: lesson_order.currency)
        expect(stripe_price).not_to be_nil
      end

      it "creates a stripe checkout session with an associated lesson order" do
        stripe_price = Stripe::Price.create(product: stripe_product.id, unit_amount: lesson_order.amount, currency: lesson_order.currency)


      # Create the checkout session for the lesson_order
      checkout_session = Stripe::Checkout::Session.create(
        line_items: [{
          price_data: {
            currency: 'usd',
            unit_amount: ((lesson.price * lesson_order.package) * 100).to_i,
            product_data: {
              name: "Your lesson",
              description: "Lessons",
              images: [''],
            },
          },
          quantity: 1,
        }],
        mode: 'payment',
        success_url: "http://localhost:3000/",
        cancel_url: "http://localhost:3000/"
      )

      lesson_order.update(stripe_session_id: checkout_session.id)
      expect(lesson_order.stripe_session_id).to eq(checkout_session.id)
      expect(checkout_session.line_items.data.first.price_data.unit_amount).to eq(((lesson.price * lesson_order.package) * 100).to_i)
      end
    end
  end
end
