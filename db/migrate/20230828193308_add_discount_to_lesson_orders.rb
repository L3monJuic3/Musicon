class AddDiscountToLessonOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :lesson_orders, :discount, :integer
  end
end
