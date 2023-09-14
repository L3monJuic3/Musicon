class AddColumnToLessonOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :lesson_orders, :state, :string
  end
end
