require 'rubygems'
require 'sinatra'

get '/form' do
  erb :form
end

post '/form' do
  "You said '#{params[:month]}'"
end

post '/form' do
  "You said '#{params[:day]}'"
end
