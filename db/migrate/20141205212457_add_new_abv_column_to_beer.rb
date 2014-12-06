class AddNewAbvColumnToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :new_abv, :decimal, precision: 5, scale: 2
  end
end