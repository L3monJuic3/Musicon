class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show destroy]

  def index
    @lessons = Lesson.all
    @lesson_orders = User.lesson_orders(current_user.id)
  end

  def show
    # @booking = Booking.new
    # @slots_available = Slot.available.where(lesson: @lesson.id)
    @lesson = Lesson.find(params[:id])
    @lesson_order = LessonOrder.new
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    if @lesson.save
      current_user.subscribed = true if params[:subscribed] == '1'
      redirect_to lessons_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @lesson = Lesson.find(params[:id])
    if @lesson.destroy
      redirect_to lessons_path, status: :see_other
    else
      render 'lessons/index'
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :category, :description, :price, :photo, :subscribed)
  end
end
