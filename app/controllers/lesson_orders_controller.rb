class LessonOrdersController < ApplicationController

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @lesson_order = LessonOrder.new

    @lesson_order.user_id = current_user.id
    @lesson_order.lesson_id = @lesson.id
    current_user.subscribed = true if params[:subscribed] == '1'

    current_user.save
    if @lesson_order.save

      redirect_to lessons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :category, :description, :price, :photo, :subscribed)
  end
end
