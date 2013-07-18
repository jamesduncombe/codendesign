#
# Main Aggregator
#

require 'rubygems'
require 'bundler'
Bundler.require

require 'open-uri'

require 'sinatra'

require 'rss'
require 'json'

require './lib/parse.rb'
require './lib/item.rb'
require './lib/rss.rb'
require './lib/json.rb'
require './lib/cache.rb'

set :haml, format: :html5

# Routes

before do
  cache_control :public, max_age: 3600 # 1 hour
end

get '/' do
  @items = CD::Parse.get_feeds
  haml :index
end

# feed address
get '/feed.xml' do
  content_type = 'application/xml'
  @items = CD::Parse.get_feeds
  CD::Rss.new({ feed_items: @items }).get_rss
end

get '/feed.json' do
  content_type = 'application/json'
  @items = CD::Parse.get_feeds
  CD::Json.new({ feed_items: @items }).get_json
end
