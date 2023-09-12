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

  private

  def lesson_params
    params.require(:lesson_order).permit(:duration, :is_subscribed, :package, :custom_hidden_field)
  end
end
