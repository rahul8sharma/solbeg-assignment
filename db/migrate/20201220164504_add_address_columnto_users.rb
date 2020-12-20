class AddAddressColumntoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :json
  end
end
