#
# Main Aggregator
#
require 'rubygems'
require 'bundler'
Bundler.require

%w(open-uri sinatra rss json).each { |f| require f }

Dir['./lib/sources/*.rb'].each { |f| require f }

%w(parse item rss json).each { |f| require "./lib/#{f}"}

set :slim, format: :html

# Routes

before do
  cache_control :public, max_age: 3550 # just under an hour
  @items = CD::Parse.get_feeds
  etag CD::Parse.md5(@items)
end

get '/' do
  slim :index
end

# Feed addresses

get '/feed.xml' do
  content_type = 'application/xml'
  CD::Rss.new({ feed_items: @items }).get_rss
end

get '/feed.json' do
  content_type = 'application/json'
  CD::Json.new({ feed_items: @items }).get_json
end
