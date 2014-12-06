class RemoveAbvFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :abv, :string
  end
end
