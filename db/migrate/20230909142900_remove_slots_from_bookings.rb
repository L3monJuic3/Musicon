class RemoveSlotsFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bookings, :slot, null: false, foreign_key: true
  end
end
