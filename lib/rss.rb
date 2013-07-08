module CD
  class Rss

    def initialize(args = {})
      @feed_items = args.fetch(:feed_items) { :no_feed_item_instance_given }
    end

    def get_rss
      rss = RSS::Maker.make("2.0") do |maker|
        maker.channel.author = 'James Duncombe'
        maker.channel.updated = Time.now.to_s
        maker.channel.title = 'Code & Design News'
        maker.channel.link = 'http://codendesign.herokuapp.com'
        maker.channel.description = 'A mashup of Hackers News and Design News stories from their front pages'

        @feed_items.each do |item|
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

  end
end