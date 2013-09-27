get '/:rut' do
codigo = <<-EOC
Ruby 1.8: <tt>([*0..9]+['K'])[rut.reverse.chars.inject([0,0]){|(i,a),n|[i+1,a-n.to_i*(i%6+2)]}[1]%11]</tt>
<br>
Ruby 1.9: <tt>[*0..9,'K'][rut.reverse.chars.inject([0,0]){|(i,a),n|[i+1,a-n.to_i*(i%6+2)]}[1]%11]</tt>
<p>
Créditos a <a href="https://twitter.com/Fergusmor">Guillermo Campos</a> por tomar la fórmula anterior de 88 carácteres y dejarla en 83 (septiembre 2013).
</p>
La de 88 carácteres: <tt>[*0..9,'K',0][11-rut.reverse.chars.inject([0,0]){|(i,a),n|[i+1,a+n.to_i*(i%6+2)]}[1]%11] </tt>
</body></html>
EOC

llout = <<-EOC
<html><head><title>RUT</title>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-11840444-1");
pageTracker._trackPageview();
} catch(err) {}</script>
</head><body><p style='font-size:30px;font-family:Gill Sans,Trebuchet MS;text-align:center'>#{params[:rut]}-#{dv(params[:rut])}</p><br>
EOC

falla = <<-EOC
<html><head><title>RUT</title>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-11840444-1");
pageTracker._trackPageview();
} catch(err) {}</script>
</head><body>
S&oacute;lo ingrese d&iacute;gitos</body></html>
EOC

  /^\d+$/ =~ params[:rut] ? llout+codigo : falla
end

get '/?' do
  out = <<-EOC
<html>
<head>
<title>RUT</title>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-11840444-1");
pageTracker._trackPageview();
} catch(err) {}</script>
</head>
<body>
Uso: <a href='http://pumarino.org/rut/11222333'>http://pumarino.org/rut/11222333</a>
</body>
</html>
EOC
end

private

def dv(rut)
  [*0..9,'K'][rut.reverse.chars.inject([0,0]){|(i,a),n|[i+1,a-n.to_i*(i%6+2)]}[1]%11]
end
