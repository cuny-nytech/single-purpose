require 'rubygems'
require 'sinatra'

get '/' do

  if Date.parse('2018-6-8') > Date.today
  #if Date.parse('2014-10-14') > Date.today
    erb :nyet
  else
    erb :da
  end
end
