require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'awesome_print'

set :haml, format: :html5

# XML feeds
design_news = 'https://news.layervault.com/?format=rss'
hacker_news = 'http://news.ycombinator.com/rss'

design_html = 'https://news.layervault.com/stories'

# simple struct to store things
Item = Struct.new(:from, :title, :description, :link)

def parse_xml(feed)
  doc = Nokogiri::XML(open(feed))
  items = []
  doc.search('item').each do |doc_item|
    items << Item.new(
      (feed =~ /layervault/ ? 'design' : 'hacker'),
      doc_item.at('title').text,
      doc_item.at('description').text,
      doc_item.at('link').text
    )
  end
  items
end

def parse_html(html)
  doc = Nokogiri.HTML(open(html))
  items = []
  doc.search('.Story').each do |doc_item|
    items << doc_item.at('.Timeago').text
  end
  items
end

get '/' do
  # join our 2 arrays together with the union function
  hn, dn = parse_xml(hacker_news), parse_xml(design_news)
  arr =  dn | hn
  @items = []
  1.upto arr.count do |n|
    @items << dn[n] unless dn[n].nil?
    @items << hn[n] unless hn[n].nil?
  end
  haml :index
end