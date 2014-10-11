require 'rubygems'
require 'sinatra'

get '/' do

  if Date.parse('2018-6-8') > Date.today
    erb :nyet
  else
    erb :da	   
  end
end
