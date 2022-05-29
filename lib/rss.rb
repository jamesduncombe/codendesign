module CD
  class Rss

    def initialize(args = {})
      @feed_items = args.fetch(:feed_items) { :no_feed_item_instance_given }
    end

    def get_rss
      rss = RSS::Maker.make("2.0") do |maker|
        maker.channel.author = 'James Duncombe'
        maker.channel.lastBuildDate = DateTime.now.rfc822
        maker.channel.title = 'Code & Design News'
        maker.channel.link = 'http://cnd.jdun.co'
        maker.channel.description = 'Aggregator of Code, Security and Design news sites.'

        @feed_items.each do |item|
          maker.items.new_item do |new_item|
            new_item.link = item.link
            new_item.title = item.title
            new_item.description = item.description
            new_item.comments = item.comments
            new_item.pubDate = item.updated_at.rfc822
          end
        end

      end

      rss.to_s
    end

  end
end
