class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :likes
  has_many :reviews
  has_many :users, through: :likes

  scope :query,  ->(query){ where("lower(name)||lower(style) LIKE ?", "%#{query.downcase}%") }
  scope :style, ->(style){ where("lower(style) LIKE ?", "%#{style.downcase}%") }
  scope :max_abv, ->(max_abv){ where("abv <= ?", "#{max_abv}")}
  scope :min_abv, ->(min_abv){ where("abv >= ?", "#{min_abv}")}

  def as_json(options=nil)
    super(except: [:created_at, :updated_at])
  end

  def self.beer_search(query)
    eager_load(:brewery).where( 'lower(breweries.name) || lower(beers.name) || lower(style) LIKE ?', "%#{query.downcase}%").limit(100)
  end

end
