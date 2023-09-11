class AddColumnToBookingSlots < ActiveRecord::Migration[7.0]
  def change
    add_reference :booking_slots, :booking, null: false, foreign_key: true
    add_reference :booking_slots, :slot, null: false, foreign_key: true
  end
end
