require 'open-uri'
require 'nokogiri'
require 'digest/md5'

require './lib/rss_parser'

Dir['./lib/sources/*.rb'].each { |f| require f }

module CD
  class Parse

    FEEDS = [
      Sources::TheHackerNews,
      Sources::HackerNews,
      Sources::DesignerNews,
      Sources::ArsSecurity
    ]

    def self.get_feeds
      FEEDS
        .each_with_object([]) { |feed, accm| accm << feed.parse }
        .flatten
        .each_with_object({}) { |item, accm| accm[item.md5] = item }
        .values
        .sort
    end

    def self.md5(feed_data)
      Digest::MD5.hexdigest(feed_data.first.title.to_s)
    end

  end
end
