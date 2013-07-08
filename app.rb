#
# Main Aggregator
#

require 'rubygems'
require 'bundler'
Bundler.require

require 'open-uri'

require 'sinatra'
require 'sinatra/cache'

require 'rss'
require 'json'

require './lib/parse.rb'
require './lib/item.rb'
require './lib/rss.rb'
require './lib/json.rb'
require './lib/cache.rb'

set :haml, format: :html5

set :root, File.dirname(__FILE__)
set :cache_enabled, true
set :cache_output_dir, Proc.new { File.join(root, 'public', 'cache') }

#include CD::Cache

#CD::Cache.cache_config({ cache_store: 'production' })

# Routes

get '/' do
  @items = CD::Parse.get_feeds
  #cache 'html', expires_in: 3600 do
  haml :index
  #end
end

# feed address
get '/feed.xml' do
  content_type = 'application/xml'
  @items = CD::Parse.get_feeds
  #cache 'rss', expires_in: 3600 do
    CD::Rss.new({ feed_items: @items }).get_rss
  #end
end

get '/feed.json' do
  content_type = 'application/json'
  @items = CD::Parse.get_feeds
  #cache 'json', expires_in: 3600 do
    CD::Json.new({ feed_items: @items }).get_json
  #end
end