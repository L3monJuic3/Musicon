class RemovePackageFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :package, :integer
  end
end
