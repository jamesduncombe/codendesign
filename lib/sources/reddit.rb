module Sources
  class Reddit

    extend CD::AtomParser

    def self.parse
      get_feed('https://www.reddit.com/r/programming/.rss') do |xml|
        parse_feed(xml) do |item|
          {
            title: item.at('title').text,
            link: item.at('link').values.first,
            comments: item.at('link').values.first,
            updated_at: updated_at(item),
            link_to_comments: item.at('link').values.first,
            link_host: 'reddit.com'
          }
        end
      end
    end

    private

    def self.updated_at(item)
      unless item.at('updated').nil?
        DateTime.parse(item.at('updated').text)
      end
    end

    def self.link_host(link)
      URI(link.split('#').first.gsub(/[^\w_\/-:.]+/, '')).host
    rescue
      ":("
    end

  end
end
