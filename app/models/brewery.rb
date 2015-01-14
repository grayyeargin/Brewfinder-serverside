class Brewery < ActiveRecord::Base
  has_many :beers

  scope :query,  ->(query){ where("lower(name)||lower(location) LIKE ?", "%#{query.downcase}%") }
  scope :location, ->(location){ where("lower(location) LIKE ?", "%#{location.downcase}%") }
  # scope :brewery_name, -> (brewery_name){ where("lower(name) LIKE ?", "%#{brewery_name.downcase}%") }
  # scope :beer, -> (beer){ where("lower(beers) LIKE ?", "%#{beer.downcase}%") }


  def as_json(options=nil)
    super(except: [:created_at, :updated_at])
  end

end



# Brewery.each do |brewery|

# SELECT
#   location,
#   COUNT(*) AS num
# FROM
#   breweries
# GROUP BY
#   location

# File.open("public/temp.json","w") do |f|


#   Brewery.each do |brewery|
#     url = "https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=#{brewery.location}+county+name"







#   File.open("public/temp.json","w") do |f|
#     f.write(tempHash.to_json)
#   end

# SELECT
#   name,
#   COUNT(*) AS num
# FROM
#   breweries
# GROUP BY
# name
# ORDER BY
# num DESC;

# Brewery.all.each do |brewery|
#   similar_breweries = Brewery.where(name: "#{brewery.name}")
#   length = similar_breweries.count
#   if length >= 2
#     similar_breweries[1..(length-1)].each { |sim_brew| sim_brew.destroy! }
#   end
# end

# brewsky.each do |brewery|
#   similar_breweries = Brewery.where(name: "#{brewery}")
#   length = similar_breweries.count
#   if length >= 2
#     similar_breweries[1..(length-1)].each { |sim_brew| sim_brew.destroy! }
#   end
# end

# states.each do |state|
#   total_breweries = Brewery.where("lower(location) LIKE ?", "%#{state}%")
#   case grade
#   when "A"
#   puts 'Well done!'
#   when "B"
#   puts 'Try harder!'
#   when "C"
#   puts 'You need help!!!'
#   else
#   puts "You just making it up!"
#   end
#   puts "#{state}" => {
#     fillKey: "",
#     numberOfThings: 0
#   }
# end

# states.each do |state|
#   total_breweries = Brewery.where("lower(location) LIKE ?", "%#{state.downcase}%").count
#   @array << state + ": " + total_breweries.to_s
# end

# @num = 0
# 50.times do
#   puts state+":" {
#     fillKey:
#     numberOfBreweries:
#     population:
#   }



# data.css('div#mw-content-text tr td a')[49].text

# 143,552 = Cali
# 34,128 = CO


