class LessonOrdersController < ApplicationController
  before_action :set_lesson, only: [:create]

  def create
    @lesson_order = LessonOrder.new(lesson_params)

    @lesson_order.user_id = current_user.id
    @lesson_order.lesson_id = @lesson.id

    current_user.subscribed = true if @lesson_order.is_subscribed == "1"
    current_user.save
    if @lesson_order.save

      redirect_to lessons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def lesson_params
    params.require(:lesson_order).permit(:duration, :is_subscribed)
  end
end
