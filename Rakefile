# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'nokogiri'
require 'open-uri'
require File.expand_path('../app/models/beer', __FILE__)
require File.expand_path('../app/models/brewery', __FILE__)

Rails.application.load_tasks


namespace :db do
  desc "seed ALL the beers yo!"
  task :seed_beer => :environment do

    breweries_array = ["Highland Brewing"]
    breweries_array.each do |brewery|
      url = "http://www.beeradvocate.com/search/?q=#{brewery.gsub(" ", "+")}+&qt=place"
      result = Nokogiri::HTML(open(url))
      @brewery = result.css('div#baContent div ul li a b')[0].text
      if result.css('div#baContent div ul li a')[0]
        link = result.css('div#baContent div ul li a')[0].attribute('href').to_s
        url = "http://www.beeradvocate.com#{link}"
        brewery = Nokogiri::HTML(open(url))

        #create brewery
        @new_brewery = Brewery.create({ location: result.css('div#baContent div ul li span')[0].text, name: @brewery, url: brewery.xpath("//tr[2]/td/a[4]").attribute('href').to_s })

        #iterate through each beer of brewery
        brewery.css("div#baContent tr")[7..-1].map do |beer|
          if beer.css("td[1] a b").text != ""
              Beer.create({ beer: beer.css("td[1] a b").text, brewery: @brewery, style: beer.css("td[2] a").text, abv: beer.css("td[3] span").text, image: "http://cdn.lifeofdad.com/uploads/profilepics/216_1333609674_11949907341218632906beer.jpg", brewery_id: @new_brewery.id })
          end
        end
      end
    end
  end

  desc "seed new_abv columb"
  task :new_abv => :environment do
    Beer.all.map do |beer|
      old_abv = beer.abv
      beer.update({new_abv: old_abv || ""})
    end
  end

  desc "add image urls for brewery"
  task :brewery_image => :environment do

    Brewery.all.each do |brewery|
      # look up image on search engine

      url = "http://www.webcrawler.com/search/images?fcoid=417&fcop=topnav&fpid=27&aid=c0b3515b-5274-4ec7-b578-eb4802fbc8b4&ridx=1&q=#{brewery.name.gsub(" ", "+")}+logo&ql=&ss=t"
      begin
        images = Nokogiri::HTML(open(url))
      rescue
        brewery.update(image_url: "http://upload.wikimedia.org/wikipedia/commons/2/24/The_Brewer_designed_and_engraved_in_the_Sixteenth._Century_by_J_Amman.png")
        next
      end
      # update brewery with new image
      if images.css(".resultThumbnail")[0]
        brewery.update({image_url: images.css(".resultThumbnail")[0].attribute('src').to_s })
        puts brewery.name
      else
        brewery.update(image_url: "http://upload.wikimedia.org/wikipedia/commons/2/24/The_Brewer_designed_and_engraved_in_the_Sixteenth._Century_by_J_Amman.png")
      end
    end
  end

  desc "population data"
  task :create_map_population_hashes => :environment do
    url = "http://simple.wikipedia.org/wiki/List_of_U.S._states_by_population"
    data = Nokogiri::HTML(open(url))
    @num = 0
    50.times do
      state = data.css('div#mw-content-text tr td a')[@num].text
      total_breweries = Brewery.where("lower(location) LIKE ?", "%#{state.downcase}%").count
      population = data.css('div#mw-content-text tr td:nth-child(3)')[@num].text.gsub(",","").to_i
      people_per_brewery = population / total_breweries
      if people_per_brewery < 70000
        @brew_level = "VERYHIGH"
      elsif people_per_brewery >= 70000 && people_per_brewery < 100000
        @brew_level = "HIGH"
      elsif people_per_brewery >= 100000 && people_per_brewery < 150000
        @brew_level = "MEDIUM"
      elsif people_per_brewery >= 150000 && people_per_brewery < 200000
        @brew_level = "LOW"
      else
        @brew_level = "VERYLOW"
      end

      puts "#{state}: {
        fillKey: '#{@brew_level}',
        numberOfBreweries: #{total_breweries},
        population: #{population},
        peoplePer: #{people_per_brewery}
      },"
      @num += 1
    end
  end

  desc "remove beers with no brewery"
  task :remove_nobrew_beers => :environment do
    beers = Beer.all
    beers.each do |beer|
      brewery = beer.brewery_id
      if !Brewery.find_by(id: brewery)
        beer.delete
      end
    end
  end


  desc "replace Style names with better ones"
  task :update_style_names => :environment do
    beers = Beer.all
    beers.each do |beer|
      if beer.style == "Saison / Farmhouse Ale"
        beer.update({style: "Saison"})
      end
    end
  end

  desc "replace Style names with better ones"
  task :count_styles => :environment do
    beers = Beer.all
    all_styles = []
    beers.each do |beer|
      all_styles << beer.style
    end

    unique = all_styles.uniq
    unique.each do |style|
      hash = {style: style, count: all_styles.count(style)}
      puts hash
    end
  end


  desc "replace Style names with better ones"
  task :add_images_to_beers => :environment do
    beers = Beer.where("id > 35000")
    beers.each do |beer|
      beer_query = beer.name.gsub(" ", "").gsub("'", "").gsub("(", "").gsub(")", "").gsub("!", "").gsub("(?", "")
      url = "http://#{beer_query}.jpg.to"
      begin
        images = Nokogiri::HTML(open(url))
      rescue
        next
      end
      if images.css('img')[0] && images.css('img')[0].attribute('src').to_s.length < 255
        beer.update({image: images.css('img')[0].attribute('src').to_s })
      end
      puts beer.name
    end
  end

    desc "Find better brewery images"
  task :add_images_to_breweries => :environment do
    breweries = Brewery.all
    breweries.each do |brewery|
      brewery_query = brewery.name.gsub(" ", "").gsub("'", "").gsub("(", "").gsub(")", "").gsub("!", "").gsub("(?", "")
      url = "http://#{brewery_query}.jpg.to"
      begin
        images = Nokogiri::HTML(open(url))
      rescue
        puts "NOOOOO: " + brewery.name
        next
      end
      if images.css('img')[0] && images.css('img')[0].attribute('src').to_s.length < 255
        brewery.update({image_url: images.css('img')[0].attribute('src').to_s })
      end
      puts "YAY: " + brewery.name
    end
  end

  desc "create addresses for breweries"
  task :address_for_breweries => :environment do
    breweries = Brewery.all
    breweries.each do |brewery|
      brew_location = brewery.location.split(", ")
      begin
        url = "http://www.yellowpages.com/search?search_terms=#{brewery.name.gsub(" ", "+")}&geo_location_terms=#{brew_location[0].gsub(" ", "+")}%2C+#{brew_location[1].gsub(" ", "+")}"
        response = Nokogiri::HTML(open(url))
      rescue
        puts brewery.name
        next
      end
      if response.css('p.adr span')[0] && response.css('p.adr span')[1] && response.css('p.adr span')[2] && response.css('p.adr span')[3] && response.css('li.phone.primary')[0]
        brewery.update({address: response.css('p.adr span')[0].text + ", " + response.css('p.adr span')[1].text + response.css('p.adr span')[2].text + " " + response.css('p.adr span')[3].text, phone_number: response.css('li.phone.primary')[0].text })
      end
      puts brewery.address
    end
  end

  desc "add description to beers"
  task :description_to_beers => :environment do
    beers = Beer.all
    beers.each do |beer|
      brewery_full = Brewery.find(beer.brewery_id)
      brewery_first = brewery_full.name.split(" ").first
      beer_with_brew = brewery_first + " " + beer.name
      query = beer_with_brew.downcase.split(" ").uniq.join(" ")
      url = "https://www.beermenus.com/search?q=#{query.gsub(" ", "+")}"
      begin
        response = Nokogiri::HTML(open(url))
        new_url = response.css('h3 a').attribute('href').to_s
      rescue
        puts "NOOOOOO: " + beer.name
        next
      end

      url = "https://www.beermenus.com" + new_url
      begin
        response = Nokogiri::HTML(open(url))
      rescue
        puts "NOOOOOO: " + beer.name
        next
      end

      if response.css('div.description p') && response.css('div.title h1')
        beer.update({name: response.css('div.title h1').text.strip, description: response.css('div.description p').text})
      end
      puts "BOOYA!!!: " + beer.name
    end
  end






end
