module Sources
  class ArsSecurity

    extend CD::RssParser

    def self.parse
      get_feed('http://feeds.arstechnica.com/arstechnica/security?format=xml') do |xml|
        parse_feed(xml) do |item|
          {
            title: item.at('title').text,
            description: item.at('description').text.strip!,
            link: item.at('link').text,
            comments: item.at('link').text.gsub(/click\//, ''),
            updated_at: updated_at(item),
            link_to_comments: item.at('link').text.gsub(/click\//, ''),
            link_host: 'arstechnica.com'
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

  end
end