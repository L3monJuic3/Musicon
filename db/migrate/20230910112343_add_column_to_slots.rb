class AddColumnToSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :slot_booking_date, :date
  end
end
