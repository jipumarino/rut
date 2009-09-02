require 'rubygems'
require 'sinatra'
require 'logger'

get '/:rut' do
  Logger.new('access.log').info("Remote IP:#{request.ip}, URL:#{request.url}")
  /^\d+$/ =~ params[:rut] ? "#{params[:rut]}-#{dv(params[:rut])}" : "S&oacute;lo ingrese d&iacute;gitos"
end

get '/?' do
  "Uso: <a href='http://pumarino.org/rut/11222333'>http://pumarino.org/rut/11222333</a>"
end

private

def dv(rut)
  ((0..9).to_a+["K","0"])[11-(rut.to_s.reverse.split("").map{|x| x.to_i}).zip((0..rut.size).map{|x| x%6+2}).inject(0){|x,y| x+=y[0]*y[1]}%11].to_s
end


