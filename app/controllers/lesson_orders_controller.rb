class LessonOrdersController < ApplicationController
  # before_action :set_lesson, only: [:create, :show]
  # after_action :authenticate_user!
  def index
    @lesson_orders = LessonOrder.all
    @lesson_order = LessonOrder.new
    @all_lessons = Lesson.all
    @lesson_price = Lesson.all.first.price unless Lesson.all.first.nil?
    # 1. There is no way to dynamically assign the discount right now.
    @packages = LessonOrder.all.first(5).pluck(:package).reverse
  end

  def show
    # @lesson = Lesson.find(params[:id])
    # @lesson_order = LessonOrder.new
    @lesson_order = LessonOrder.find(params[:id])
    @all_lessons = Lesson.all
  end

  def create
    duration = params[:lesson_order][:custom_hidden_field]

    # Will need to create some way to recognise the particular teacher
    @lesson = Lesson.find_by(duration: duration)
    filtered_params = lesson_params.except(:custom_hidden_field)
    @lesson_order = LessonOrder.new(filtered_params)

    @discount = LessonOrder.discount_cal(@lesson_order.package)
    @lesson_order.discount = @discount
    @lesson_order.amount_cents = (((@lesson.price * @lesson_order.package)) * @discount) * 100

    @lesson_order.user_id = current_user.id
    @lesson.present? ? @lesson_order.lesson_id = @lesson.id : @lesson_order.lesson_id = Lesson.first.id
    current_user.subscribed = true if @lesson_order.is_subscribed == true
    current_user.save
    if @lesson_order.save
      checkout(@lesson_order)
    else
      puts @lesson_order.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def checkout(lesson_order)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [[
        price_data: {
          currency: "usd",
          unit_amount: (@lesson_order.amount_cents).to_i,
          product_data: {
            name: 'Your lessons',
            description: "very nice",
            images: ['https://example.com/t-shirt.png'],
          },
        },
        quantity: 1
      ]],
      mode: 'payment',
      success_url: "http://localhost:3000/lesson_order/#{lesson_order.id}/confirmation",
      cancel_url: "http://localhost:3000/lesson_order/#{lesson_order.id}/checkout",
    )
    lesson_order.update(checkout_session_id: session.id)
    lesson_order.update(state: "pending")
    redirect_to new_lesson_order_payment_path(lesson_order)
  end

  private

  def lesson_params
    params.require(:lesson_order).permit(:duration, :is_subscribed, :package, :custom_hidden_field)
  end
end
