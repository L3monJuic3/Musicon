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
    @lesson_order.amount_cents = (@lesson.price * @lesson_order.package) * 100

    @lesson_order.user_id = current_user.id
    @lesson.present? ? @lesson_order.lesson_id = @lesson.id : @lesson_order.lesson_id = Lesson.first.id
    current_user.subscribed = true if @lesson_order.is_subscribed == true
    current_user.save
    if @lesson_order.save
      puts "#{response}"
      redirect_to lessons_path
    else
      puts "#{response}"
      render :new, status: :unprocessable_entity
    end
  end

  def checkout
    @order = LessonOrder.find(params[:id])
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [[
        price_data: {
          currency: "usd",
          unit_amount: (@order.amount_cents).to_i,
          product_data: {
            name: 'Your lessons',
            description: "very nice",
            images: ['https://example.com/t-shirt.png'],
          },
        },
        quantity: 1
      ]],
      mode: 'payment',
      success_url: "http://localhost:3000/lesson_order/#{@order.id}/confirmation"
      cancel_url: "http://localhost:3000/lesson_order/#{@order.id}/checkout"
    )
    @order.update(checkout_session_id: session.id)
  end

  private

  def lesson_params
    params.require(:lesson_order).permit(:duration, :is_subscribed, :package, :custom_hidden_field)
  end
end
