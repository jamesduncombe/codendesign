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
  @items = CD::Parse.get_feeds
  etag CD::Parse.md5(@items)
end

get '/' do
  haml :index
end

# feed address
get '/feed.xml' do
  content_type = 'application/xml'
  CD::Rss.new({ feed_items: @items }).get_rss
end

get '/feed.json' do
  content_type = 'application/json'
  CD::Json.new({ feed_items: @items }).get_json
end
