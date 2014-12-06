class AddImageColumnToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :image_url, :string
  end
end
