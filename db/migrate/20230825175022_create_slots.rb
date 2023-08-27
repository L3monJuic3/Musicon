class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.time :start_time
      t.time :end_time
      t.boolean :is_available
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
