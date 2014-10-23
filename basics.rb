require 'sinatra'
require 'rubygems'

get '/' do 
	erb :formQ
end

get '/answer' do 
	erb :formA
end

not_found do 
	status 404
	'not found'
end
