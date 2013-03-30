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

set :haml, format: :html5

# XML feeds
DESIGN_NEWS = 'https://news.layervault.com/?format=rss'
HACKER_NEWS = 'https://news.ycombinator.com/rss'

# Item - class to store the info for the model of RSS data
class Item

  attr_accessor :from, :title, :description, :link, :comments, :updated_at

  def initialize(*args)
    args.first.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def link_to_article
    if self.from == 'design'
      # protect against questions asked on designer news
      return self.description if self.description =~ /^https?\:\/\//
      self.link
    else
      self.link
    end
  end

  def link_to_comments
    if self.from == 'design'
      self.link
    else
      self.comments
    end
  end

  def link_host
    # URI gets freaked out if there's a hash in the address
    URI(self.link_to_article.split('#').first).host
  end

  def to_hash
    self.instance_variables.inject({}) do |hash,element|
      hash[element.to_s.delete('@')] = instance_variable_get(element)
      hash
    end
  end

end

# XML parser for the feeds
def parse_xml(feed)
  doc = Nokogiri::XML(open(feed))
  items = []
  doc.search('item').each do |doc_item|
    items << Item.new(
      from:         (feed =~ /layervault/ ? 'design' : 'hacker'),
      title:        doc_item.at('title').text,
      description:  doc_item.at('description').text.strip!,
      link:         doc_item.at('link').text,
      comments:     (doc_item.at('comments').text unless doc_item.at('comments').nil?),
      updated_at:   (doc_item.at('pubDate').text unless doc_item.at('pubDate').nil?)
    )
  end
  items
end


# main method to actually get the feeds together
def get_feeds

  # parse the feeds
  hn, dn = parse_xml(HACKER_NEWS), parse_xml(DESIGN_NEWS)

  # zip the arrays together
  # this interpolates the 2 arrays [[1,1], [2,2]] etc
  # then flatten them and remove any nil keys
  # then finally make sure only unique titles are shown
  hn.zip(dn).flatten!.compact

end

# Routes

get '/' do

  @items = get_feeds

  # render the template
  haml :index

end

# feed address
get '/feed.xml' do

  content_type = 'application/xml'

  @items = get_feeds

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

  @items = get_feeds

  h = []
  @items.each do |i|
    h << i.to_hash
  end

  h.to_json

end