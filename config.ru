require 'haml'
require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/fonts', '/js', '/images', '/videos', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  set :author,    'Jason Ormand'                            # blog author
  set :title,     'Blog for Developer and Designer - Jason Ormand'                         # site title
  set :url,				'http://jasonormand.com'
  set :root,      "index"                                   # page to load on /
  set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    false                                     # disqus id, or false
  set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'txt'                                     # file extension for articles
  set :cache,     32000000                                    # cache duration, in seconds
  set :date,      lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :to_html,   lambda {|path, page, ctx|
    ::Haml::Engine.new(File.read("#{path}/#{page}.haml"), :format => :html5, :ugly => true).render(ctx)
  }


end

run toto


