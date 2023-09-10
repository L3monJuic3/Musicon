class ChangeBookingDateColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :booking_date, :date
  end
end
