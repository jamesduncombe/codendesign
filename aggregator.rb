# Pull in required files
%w(sinatra nokogiri open-uri sass haml).each do |dependency|
  require dependency
end

set :haml, format: :html5

# XML feeds
design_news = 'https://news.layervault.com/?format=rss'
hacker_news = 'http://news.ycombinator.com/rss'

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
    URI(self.link_to_article).host
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
      comments:     (doc_item.at('comments').text unless doc_item.at('comments').nil?)
    )
  end
  items
end

# Routes

get '/' do

  # parse the feeds
  hn, dn = parse_xml(hacker_news), parse_xml(design_news)

  # zip the arrays together
  # this interpolates the 2 arrays [[1,1], [2,2]] etc
  # then flatten them and remove any nil keys
  # then finally make sure only unique titles are shown
  @items = hn.zip(dn).flatten!.compact.uniq!(&:title)

  # render the template
  haml :index

end