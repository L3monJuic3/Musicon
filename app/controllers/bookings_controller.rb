class BookingsController < ApplicationController

  def index
    @bookings = Booking.all

    @lesson_orders = LessonOrder.where(user_id: current_user)

    @package = @lesson_orders.pluck(:package).last
  end
end
