module Sources
  class HackerNews

    extend CD::RssParser

    def self.parse
      get_feed('https://news.ycombinator.com/rss') do |xml|
        parse_feed(xml) do |item|
          {
            title: item.at('title').text,
            description: item.at('description').text.strip!,
            link: item.at('link').text,
            comments: item.at('comments').text,
            updated_at: updated_at(item),
            link_to_comments: item.at('comments').text,
            link_host: link_host(item.at('link').text)
          }
        end
      end
    end

    private

    def self.updated_at(item)
      unless item.at('pubDate').nil?
        DateTime.parse(item.at('pubDate').text)
      end
    end

    def self.link_host(link)
      URI(link.split('#').first.gsub(/[^\w_\/-:.]+/, '')).host
    rescue
      'woops, can\'t parse'
    end

  end
end