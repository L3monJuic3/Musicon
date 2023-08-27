class AddColumnToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :duration, :time
  end
end
