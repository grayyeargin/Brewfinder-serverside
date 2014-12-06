class Brewery < ActiveRecord::Base
  has_many :beers

  scope :query,  -> (query){ where("lower(name)||lower(location) LIKE ?", "%#{query.downcase}%") }
  scope :location, -> (location){ where("lower(location) LIKE ?", "%#{location.downcase}%") }
  # scope :brewery_name, -> (brewery_name){ where("lower(name) LIKE ?", "%#{brewery_name.downcase}%") }
  # scope :beer, -> (beer){ where("lower(beers) LIKE ?", "%#{beer.downcase}%") }


  def as_json(options=nil)
    super(except: [:created_at, :updated_at])
  end

end
