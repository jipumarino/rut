# This file goes in domain.com/config.ru
require 'rubygems'
require 'sinatra'
 
Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)
 
require 'rut.rb'
run Sinatra.application

