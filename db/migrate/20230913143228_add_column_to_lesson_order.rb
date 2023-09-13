class AddColumnToLessonOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :lesson_orders, :amount_cents, :integer
    add_column :lesson_orders, :checkout_session_id, :string
  end
end
