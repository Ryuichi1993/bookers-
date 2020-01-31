class RenamePostColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :post, :postcode
  end
end
