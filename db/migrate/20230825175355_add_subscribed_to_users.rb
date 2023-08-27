class AddSubscribedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscribed, :boolean
  end
end
