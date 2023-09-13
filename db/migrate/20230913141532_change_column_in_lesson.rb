class ChangeColumnInLesson < ActiveRecord::Migration[7.0]
  def change
    add_monetize :lessons, :price, currency: { present: false }
  end
end
