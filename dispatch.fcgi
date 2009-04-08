#!/usr/bin/ruby -d

ENV["GEM_HOME"]="/home/thefoura/gems"
ENV["GEM_PATH"]="/home/thefoura/gems:/usr/lib/ruby/gems/1.8"

require 'rubygems'
require 'sinatra'

fastcgi_log = File.open("fastcgi.log", "a")
STDOUT.reopen fastcgi_log
STDERR.reopen fastcgi_log
STDOUT.sync = true

set :logging, true
set :server, "FastCGI"

module Rack
  class Request
    def initialize(env)
      @env = env
      @env["REDIRECT_URL"].gsub!(/^\/rut/,'')
      @env["REQUEST_PATH"] = @env["REDIRECT_URL"]
    end
    def path_info
      @env["REDIRECT_URL"].to_s
    end
    def path_info=(s)
      @env["REDIRECT_URL"] = s.to_s
    end
  end
end


load 'controller.rb'

