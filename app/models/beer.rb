class Beer < ActiveRecord::Base
  belongs_to :brewery

  scope :query,  -> (query){ where("lower(name) LIKE ?", "%#{query.downcase}%") }
  scope :style, -> (style){ where("lower(style) LIKE ?", "%#{style.downcase}%") }

  def as_json(options=nil)
    super(except: [:created_at, :updated_at])
  end

end
