require 'webrick'
require 'haml'
include WEBrick

s = HTTPServer.new(Port: 2000)

class HelloServlet < HTTPServlet::AbstractServlet
  def do_GET(req, res)
    res['Content-Type'] = "text/html"
    haml_code = <<-EOM
%html
  %body
    %p Hello. You're calling from a #{req['User-Agent']}
    %p I see parameters: #{req.query.keys.join(', ')}
EOM
    engine = Haml::Engine.new(haml_code)
    res.body = engine.render
  end
end

s.mount("/hello", HelloServlet)
trap("INT") {s.shutdown}
s.start
