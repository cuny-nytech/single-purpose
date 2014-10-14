
require 'sinatra'
require 'json'
require 'httparty'

time = Time.new
weather = ['chanceflurries', 'chancerain', 'chancesleet', 'chancesnow', 'chancetstorms',
           'clear', 'cloudy', 'flurries', 'fog', 'hazy', 'mostlycloudy', 'mostlysunny',
           'partlycloudy', 'partlysunny', 'rain', 'sleet', 'snow', 'sunny', 'tstorms']

# This is way to pass secret arguments to program 
# or as environment variable
API_KEY = ARGV[0]

result = []
query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/CA/San_Francisco.json"
res = HTTParty.get(query)
parsed = JSON.parse(res.body)
data = parsed['current_observation']
result << data
query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/NY/New_York.json"
res = HTTParty.get(query)
parsed = JSON.parse(res.body)
data = parsed['current_observation']
result << data
query = "http://api.wunderground.com/api/"+API_KEY+"/conditions/q/IL/Chicago.json"
res = HTTParty.get(query)
parsed = JSON.parse(res.body)
data = parsed['current_observation']
result << data



get '/' do
  @conditions = []

  result.each do |item|
    @con = item 
    @con["icon_source"] = File.expand_path("/images/" + item['icon'] + ".gif", settings.public_folder)
    @con["picture"] = File.expand_path("/images/" + item['display_location']['city'] + ".jpeg", settings.public_folder) 
   @conditions << @con
  end

  erb :home
 
end



