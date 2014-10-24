require 'rubygems'
require 'bundler'
require 'sinatra'
require 'time'

get '/' do
  erb :is_it_weekend_yet
end
