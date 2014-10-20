require 'sinatra'
require 'rubygems'
require 'weather-api'


response = Weather.lookup(2347591)

location = response.title
temp = response.condition.temp
condition = response.condition.text
condition.downcase!

get '/' do

"The #{location} is"

#Here is a condition. Checks out the temperature and displays a message.

if temp >= 80 
	"Right now it is #{temp} degrees. Pretty hot, you might want to go to the beach."
elsif temp <= 80 || temp >= 55
	"Right now it is #{temp} degrees. Nice temperature out here. Take a nice stoll in the park" 
elsif temp <= 54 || temp >= 40
	"Right now it is #{temp} degrees. Pretty chilly out here. Sweater time."
elsif temp <=39 || temp >= 20
	"Right now it is #{temp} degrees. Man, it's cold out here. Use that awesome coat you bought."
else
	 "Right now it is #{temp} degrees. Why are you out here again?"
end

#Here is a condition. Checks out the appearance of the weather and displays a message.

if condition.include? "sunny"
	"Today's weather is #{condition}. Nice."
		erb :smiles	
else
	"Today's weather is #{condition}. I wish it was sunny :(" 
		erb :notsmiles
end
end

require './app'
run Sinatra::Application