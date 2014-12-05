class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :style
      t.string :abv
      t.string :image
      t.references :brewery
      t.timestamps
    end
  end
end
