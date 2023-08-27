class CreateLessonOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :lesson_orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
