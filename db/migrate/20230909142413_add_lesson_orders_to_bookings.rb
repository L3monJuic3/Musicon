class AddLessonOrdersToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :lesson_order, null: false, foreign_key: true
  end
end
