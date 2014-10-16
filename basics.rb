require 'sinatra'
require 'rubygems'

get '/' do 
	erb :form
end

not_found do 
	status 404
	'not found'
end
