class RemoveDurationFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :duration, :time
  end
end
