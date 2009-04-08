require 'rubygems'
require 'sinatra'
require 'logger'

module Rack
  class Request
    def ip
      if addr = @env['HTTP_X_FORWARDED_FOR']
        addr.split(',').last.strip
      else
        @env['REMOTE_ADDR']
      end
    end
  end
end

get '/:rut' do
  Logger.new('access.log').info("Remote IP:#{request.ip}, URL:#{request.url}")
  rut = params[:rut]
  splitted = rut.split("-")
  rut = splitted.first.to_i
  rut.to_s+"-"+dv(rut)
end

get '/' do
  "Uso: <a href='http://pumarino.org/rut/11222333'>http://pumarino.org/rut/11222333</a>"
end

private

def dv(rut_test)
    v=1
    s=0
    for i in (2..9)
      if i == 8
        v=2
      else
        v+=1
      end
      s+=v*(rut_test%10)
      rut_test/=10
    end
    
    s = 11 - s%11
    
    if s == 11
      correct_dv = "0"
    elsif s == 10
      correct_dv = "K"
    else
      correct_dv = s.to_s
    end

    correct_dv
end

