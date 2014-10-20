# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

#require './is_it_weekend_yet'
#require 'bundler'
#require 'bundler/setup'
#require 'logger'
run Sinatra::Application
#bundle config
#run Sinatra::Contrib
