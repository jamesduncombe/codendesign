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

set :haml, format: :html5

# Routes

get '/' do
  @items = Parse.get_feeds
  # render the template
  haml :index
end

# feed address
get '/feed.xml' do
  content_type = 'application/xml'
  @items = Parse.get_feeds

  rss = RSS::Maker.make("2.0") do |maker|
    maker.channel.author = 'James Duncombe'
    maker.channel.updated = Time.now.to_s
    maker.channel.title = 'Code & Design News'
    maker.channel.link = 'http://codendesign.herokuapp.com'
    maker.channel.description = 'A mashup of Hackers News and Design News stories from their front pages'

    @items.each do |item|
      maker.items.new_item do |new_item|
        new_item.link = item.link
        new_item.title = item.title
        new_item.description = item.description
        new_item.comments = item.comments
        new_item.updated = item.updated_at
      end
    end

  end

  rss.to_s

end

get '/feed.json' do
  content_type = 'application/json'
  @items = Parse.get_feeds

  h = []
  @items.each do |i|
    h << i.to_hash
  end

  h.to_json

end