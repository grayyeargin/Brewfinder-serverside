class AddDescriptionToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :description, :text
  end
end
