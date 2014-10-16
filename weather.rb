
require 'sinatra/base'
require 'json'
require 'httparty'
require 'data_mapper'

# This is way to pass secret arguments to program 
# or as environment variable
API_KEY = ENV['WEATHER']

# If you want the logs displayed you have to do this before the call to set
DataMapper::Logger.new($stdout, :debug)

# A Postgres connection
DataMapper.setup(:default, 'postgres://pedro1:pjer1976@localhost/weather')

class WeatherData
  include DataMapper::Resource

  property :id, Integer, :key => true
  property :city, Text
  property :state, Text
  property :temperature, Integer
  property :humidity, Text
  property :icon, Text
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!


class App < Sinatra::Base

  get '/' do
    @conditions = WeatherData.all :order => :id.desc
    update @conditions if update? @conditions

    erb :home
  end

  helpers  do
    def update cities
      cities.each do |city|
        #query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/#{city.state}/#{city.city}.json"
        #res = HTTParty.get(query)
        #parsed = JSON.parse(res.body)
        #data = parsed['current_observation']
        city.updated_at = Time.now
        city.save
      end
    end
  
    def update? cities
      now = Time.now
      latest = 0
      cities.each do |city|
        latest = latest > now - city.updated_at.to_time ? latest : now - city.updated_at.to_time
      end
      
      latest > 120
    end
  end

end

