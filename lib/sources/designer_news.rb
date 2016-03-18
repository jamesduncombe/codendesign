module Sources
  class DesignerNews

    extend CD::RssParser

    def self.parse
      get_feed('https://www.designernews.co/?format=rss') do |xml|
        parse_feed(xml) do |item|
          {
            title: item.at('title').text,
            description: item.at('description').text.strip!,
            link: item.at('link').text,
            comments: item.at('link').text.gsub(/click\//, ''),
            updated_at: updated_at(item),
            link_to_comments: item.at('link').text.gsub(/click\//, ''),
            link_host: link_host(item.at('description').text)
          }
        end
      end
    end

    private

    def self.updated_at(item)
      unless item.at('pubDate').nil?
        DateTime.parse(item.at('pubDate').text).new_offset(0)
      end
    end

    def self.link_host(link)
      URI(link.split('#').first.gsub(/[^\w_\/-:.]+/, '')).host
    rescue
      'woops, can\'t parse'
    end

  end
end