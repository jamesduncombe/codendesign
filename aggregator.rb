%w(sinatra nokogiri open-uri sass haml).each do |f|
  require f
end

set :haml, format: :html5

# XML feeds
design_news = 'https://news.layervault.com/?format=rss'
hacker_news = 'http://news.ycombinator.com/rss'

design_html = 'https://news.layervault.com/stories'

# Item - class to store the info for the model of RSS data
class Item

  attr_accessor :from, :title, :description, :link, :comments

  def initialize(*args)
    args.first.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def link_to_article
    if self.from == 'design'
      self.description.strip
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
    URI(self.link_to_article).host
  end

end

# XML parser for the feeds
def parse_xml(feed)
  doc = Nokogiri::XML(open(feed))
  items = []
  doc.search('item').each do |doc_item|
    items << Item.new(
      from: (feed =~ /layervault/ ? 'design' : 'hacker'),
      title: doc_item.at('title').text,
      description: doc_item.at('description').text,
      link: doc_item.at('link').text,
      comments: (doc_item.at('comments').text unless doc_item.at('comments').nil?)
    )
  end
  items
end

# XML parser for the pages
def parse_html(html)
  doc = Nokogiri.HTML(open(html))
  items = []
  doc.search('.Story').each do |doc_item|
    items << doc_item.at('.Timeago').text
  end
  items
end

get '/' do

  # parse the feeds
  hn, dn = parse_xml(hacker_news), parse_xml(design_news)

  # zip the arrays together
  # this interpolates the 2 arrays [[1,1], [2,2]] etc
  # then flatten them and remove any nil keys
  @items = hn.zip(dn).flatten!.compact

  # render the template
  haml :index

end