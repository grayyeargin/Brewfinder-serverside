class AddAvgRatingColumnToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :like_no, :integer
    add_column :beers, :rating_no, :integer
    add_column :beers, :avg_rating, :decimal, precision: 5, scale: 2
  end
end
