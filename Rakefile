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
end
