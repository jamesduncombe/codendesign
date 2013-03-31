require 'open-uri'
require 'nokogiri'

class Parse

  DESIGN_NEWS = 'https://news.layervault.com/?format=rss'
  HACKER_NEWS = 'https://news.ycombinator.com/rss'

  def self.record(doc_item, feed)
    Item.new(
      from:         self.from(feed),
      title:        self.title(doc_item),
      description:  self.description(doc_item),
      link:         self.link(doc_item),
      comments:     self.comments(doc_item),
      updated_at:   self.updated_at(doc_item)
    )
  end

  def self.feed_data(feed)
    Nokogiri::XML(open(feed))
  end

  # XML parser for the feeds
  def self.parse_xml(doc, feed)
    items = []
    doc.search('item').each do |doc_item|
      items << self.record(doc_item, feed)
    end
    items
  end

  # main method to actually get the feeds together
  def self.get_feeds

    hnd = self.feed_data(HACKER_NEWS)
    dnd = self.feed_data(DESIGN_NEWS)

    # parse the feeds
    hn, dn = self.parse_xml(hnd, HACKER_NEWS), self.parse_xml(dnd, DESIGN_NEWS)

    # zip the arrays together
    # this interpolates the 2 arrays [[1,1], [2,2]] etc
    # then flatten them and remove any nil keys
    # then finally make sure only unique titles are shown
    hn.zip(dn).flatten!.compact

  end

  private

    def self.from(feed)
      feed =~ /layervault/ ? 'design' : 'hacker'
    end

    def self.title(doc_item)
      doc_item.at('title').text
    end

    def self.description(doc_item)
      doc_item.at('description').text.strip!
    end

    def self.link(doc_item)
      doc_item.at('link').text
    end

    def self.comments(doc_item)
      doc_item.at('comments').text unless doc_item.at('comments').nil?
    end

    def self.updated_at(doc_item)
      doc_item.at('pubDate').text unless doc_item.at('pubDate').nil?
    end

end