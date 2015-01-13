class AddAgeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
    add_column :users, :city, :string
    add_column :users, :state, :string
  end
end
