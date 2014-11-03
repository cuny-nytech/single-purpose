require 'rubygems'
require 'Sinatra'
require 'bundler/setup'


get '/index' do
  erb :index
end


post '/name' do
  if params[:message] == ""
    params[:message] = "_no_entry"
  end
  erb :name
end

