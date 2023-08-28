class LessonOrdersController < ApplicationController
  # before_action :set_lesson, only: [:create, :show]

  def index
    @lesson_orders = LessonOrder.all
    @lesson_order = LessonOrder.new
    @all_lessons = Lesson.all
  end

  def show
    # @lesson = Lesson.find(params[:id])
    @lesson_order = LessonOrder.new
    @all_lessons = Lesson.all
  end

  def create
    duration = params[:lesson_order][:custom_hidden_field]

    @lesson = Lesson.where(duration: duration).first

    filtered_params = lesson_params.except(:custom_hidden_field)

    @lesson_order = LessonOrder.new(filtered_params)

    @lesson_order.user_id = current_user.id
    @lesson_order.lesson_id = @lesson.id

    current_user.subscribed = true if @lesson_order.is_subscribed == true
    current_user.save

    if @lesson_order.save

      redirect_to lessons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lesson_params
    params.require(:lesson_order).permit(:duration, :is_subscribed, :package, :custom_hidden_field)
  end
end
