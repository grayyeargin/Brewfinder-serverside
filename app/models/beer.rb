class Beer < ActiveRecord::Base
  belongs_to :brewery

  scope :query,  -> (query){ where("lower(name)||lower(style) LIKE ?", "%#{query.downcase}%") }
  scope :style, -> (style){ where("lower(style) LIKE ?", "%#{style.downcase}%") }
  scope :max_abv, -> (max_abv){ where("abv <= ?", "#{max_abv}")}
  scope :min_abv, -> (min_abv){ where("abv >= ?", "#{min_abv}")}

  def as_json(options=nil)
    super(except: [:created_at, :updated_at])
  end

end
