class AddPackageToLessonOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :lesson_orders, :package, :integer
  end
end
