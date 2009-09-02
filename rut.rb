require 'rubygems'
require 'sinatra'
require 'logger'

get '/:rut' do
  Logger.new('access.log').info("Remote IP:#{request.ip}, URL:#{request.url}")
  rut = params[:rut]
  splitted = rut.split("-")
  rut = splitted.first
  /^\d+$/ =~ rut ? rut.to_s+"-"+dv(rut) : "Car&aacute;cter no v&aacute;lido"
end

get '/?' do
  "Uso: <a href='http://pumarino.org/rut/11222333'>http://pumarino.org/rut/11222333</a>"
end

private

def dv(rut)
  ((0..9).to_a+["K","0"])[11-(rut.to_s.reverse.split("").map{|x| x.to_i}).zip((2..7).to_a * ((rut.size/6.0).ceil)).inject(0){|x,y| x+=y.first*y.last}%11].to_s
end


