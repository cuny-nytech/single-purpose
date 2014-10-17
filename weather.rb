
require 'sinatra/base'
require 'json'
require 'httparty'
require 'data_mapper'
#require 'sinatra/config_file'

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


  def self.initialize_database
    cities = ["New_York", "San_Francisco", "Chicago"]
    states = ["NY", "CA", "IL"]

    3.times do |i|
      c = WeatherData.new
      c.id = i
      c.city = cities[i].tr('_', ' ')
      c.state = states[i].tr('_', ' ')
      self.make_api_call(c, states[i], cities[i])
    end

  end


  def self.make_api_call(db_record, state, city)
    query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/#{state}/#{city}.json"
    res = HTTParty.get(query)
    parsed = JSON.parse(res.body)
    data = parsed['current_observation']
    db_record.humidity = data['relative_humidity']
    db_record.temperature = data['temp_f']
    db_record.icon = data['icon']
    db_record.updated_at = Time.now
    db_record.save
  end


  # make sure we have something in the database
  configure do
    #config_file 'conf.yaml'
    data = WeatherData.all
    self.initialize_database if data.size == 0
  end

  get '/' do
    @conditions = WeatherData.all :order => :id.desc
    update @conditions if update? @conditions

    erb :home
  end

  helpers do
    def update cities
      cities.each do |city|
        update_db(city, city.state, city.city.tr(' ', '_'))
      end
    end
  
    def update? cities
      now = Time.now
      latest = 0
      cities.each do |city|
        latest = latest > now - city.updated_at.to_time ? latest : now - city.updated_at.to_time
      end
      
      latest > 300
    end

    def update_db(db_record, state, city)
      query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/#{state}/#{city}.json"
      res = HTTParty.get(query)
      parsed = JSON.parse(res.body)
      data = parsed['current_observation']
      db_record.humidity = data['relative_humidity']
      db_record.temperature = data['temp_f']
      db_record.icon = data['icon']
      db_record.updated_at = Time.now
      db_record.save
    end
  end

end

