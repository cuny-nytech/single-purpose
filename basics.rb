require 'sinatra'
require 'rubygems'

temp = Time.now
todaysDate = temp.strftime("%A").downcase!

get '/' do
	erb :form
end

post '/form' do
	if todaysDate == params[:dayoftheweek].downcase
		erb :yes
	else
		erb :no
	end
end

not_found do
	halt 404, 'page not found'
end