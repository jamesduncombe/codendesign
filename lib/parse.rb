require 'open-uri'
require 'nokogiri'
require 'digest/md5'

require './lib/sources/source'

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
        .compact
        .sort { |a,b| b.updated_at <=> a.updated_at }
    end

    def self.md5(feed_data)
      Digest::MD5.hexdigest(feed_data.first.title.to_s)
    end

  end
end
