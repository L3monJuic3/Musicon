class AddPackageToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :package, :integer
  end
end
