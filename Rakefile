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

    breweries_array = ["brewery 85"]
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

    Brewery.where("id < 712").each do |brewery|
      # look up image on search engine

      url = "http://www.webcrawler.com/search/images?fcoid=417&fcop=topnav&fpid=2&aid=8a6747f9-1560-4e3c-a4fc-23a94a890691&ridx=4&q=#{brewery.name.gsub(" ", "+")}+logo+.jpg&ql=&ss=t"
      begin
        images = Nokogiri::HTML(open(url))
      rescue
        brewery.update(image_url: "http://nancyharmonjenkins.com/wp-content/plugins/nertworks-all-in-one-social-share-tools/images/no_image.png")
        next
      end
      # update brewery with new image
      if images.css('#imageResults a img')[0]
        brewery.update({image_url: images.css('#imageResults a img')[0].attribute('src').to_s})
      else
        brewery.update(image_url: "http://nancyharmonjenkins.com/wp-content/plugins/nertworks-all-in-one-social-share-tools/images/no_image.png")
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

end
