class AddDurationToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :duration, :integer
  end
end
