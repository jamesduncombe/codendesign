#
# Main Aggregator
#
require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'open-uri'
require 'rss'
require 'cgi'

%w(parse item rss json rss_parser).each { |f| require "./lib/#{f}"}

Dir['./lib/sources/*.rb'].each { |f| require f }

# Routes

before do
  cache_control :public, max_age: 3550
  @items = CD::Parse.get_feeds
  etag CD::Parse.md5(@items)
end

get '/' do
  erb :index
end

# Feed addresses

get '/feed.xml' do
  content_type = 'application/xml'
  CD::Rss.new({ feed_items: @items }).get_rss
end

get '/feed.json' do
  content_type = 'application/json'
  CD::Json.get_json(@items)
end
