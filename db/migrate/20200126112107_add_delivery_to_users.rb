class AddDeliveryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :delivery, :text
    add_column :users, :post, :integer
  end
end
