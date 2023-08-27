class AddIsSubscribedToLessonOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :lesson_orders, :is_subscribed, :boolean
  end
end
