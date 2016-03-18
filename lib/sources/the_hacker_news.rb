module Sources
  class TheHackerNews

    extend CD::RssParser

    def self.parse
      get_feed('http://feeds.feedburner.com/TheHackersNews') do |xml|
        parse_feed(xml) do |item|
          {
            title: item.at('title').text,
            description: item.at('description').text.strip!,
            link: item.at('link').text,
            comments: item.at('link').text,
            updated_at: updated_at(item),
            link_to_comments: item.at('link').text,
            link_host: 'thehackernews.com'
          }
        end
      end
    end

    private

    def self.updated_at(doc_item)
      unless doc_item.at('pubDate').nil?
        DateTime.parse(doc_item.at('pubDate').text).new_offset(0)
      end
    end

  end
end