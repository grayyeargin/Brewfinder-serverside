class RenameColumnNewAbvInBeers < ActiveRecord::Migration
  def change
    rename_column :beers, :new_abv, :abv
  end
end
