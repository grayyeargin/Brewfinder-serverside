class AddAddressPhoneToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :address, :string
    add_column :breweries, :phone_number, :string
  end
end
