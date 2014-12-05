# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



  # url = "http://beerme.com/brewerylist.php"
  # breweries = Nokogiri::HTML(open(url))
  # breweries_array = breweries.css("div#content li a").map {|a| a.text }
  # breweries_array = breweries_array.map {|brewery| brewery.delete "."}
  # breweries_array = breweries_array.map {|brewery| if brewery != nil then brewery.include?("Ð") || brewery.include?("¤") || brewery.include?("â") || brewery.include?("¶") || brewery.include?("Ã") || brewery.include?("Å") || brewery.include?("Ä") ? nil : brewery end}
  # breweries_array = breweries_array.compact


  url = "http://www.bcca.com/services/brewery_listing.asp"
  breweries = Nokogiri::HTML(open(url))
  breweries_array = breweries.css("table.ClassifiedTable td b").map { |beer| beer.text.strip[1..-1].gsub("&", "").gsub(",", "").gsub("(", "").gsub(")", "").gsub("'", "").gsub("  ", " ").gsub("’", "") }
  breweries_array = breweries_array.uniq

  # breweries_array = [""]
  breweries_array[0..3361].each do |brewery|
    url = "http://www.beeradvocate.com/search/?q=#{brewery.gsub(" ", "+")}&qt=place"
    begin
      result = Nokogiri::HTML(open(url))
    rescue URI::InvalidURIError
      next
    end
    if result.css('div#baContent div ul li a')[0] && result.css('div#baContent div ul li a b')[0].text
      @brewery = result.css('div#baContent div ul li a b')[0].text
      link = result.css('div#baContent div ul li a')[0].attribute('href').to_s
      url = "http://www.beeradvocate.com#{link}"
      brewery = Nokogiri::HTML(open(url))

      begin
        @brewery_link = brewery.xpath("//tr[2]/td/a[4]").attribute('href').to_s
      rescue NoMethodError
        @brewery_link = "https://www.google.com/#q=#{brewery.gsub(" ", "+")}"
      end

      #create brewery
      new_brewery = Brewery.create({ location: result.css('div#baContent div ul li span')[0].text || "", name: @brewery, url: @brewery_link })
      @brewery_id = new_brewery.id

      #iterate through each beer of brewer
      if brewery.css("div#baContent tr")[7..-1]
        brewery.css("div#baContent tr")[7..-1].map do |beer|
          if beer.css("td[1] a b").text != ""
              Beer.create({ name: beer.css("td[1] a b").text, style: beer.css("td[2] a").text || "unknown", abv: beer.css("td[3] span").text || "unknown", image: "http://cdn.lifeofdad.com/uploads/profilepics/216_1333609674_11949907341218632906beer.jpg", brewery_id: @brewery_id})
          end
        end
      end
    end
  end
