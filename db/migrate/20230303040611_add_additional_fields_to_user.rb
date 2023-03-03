class AddAdditionalFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :additional_phone_number, :string
  end
end
