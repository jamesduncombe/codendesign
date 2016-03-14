module Sources
  class ArsSecurity

    ENDPOINT = 'http://feeds.arstechnica.com/arstechnica/security?format=xml'

    class << self

      def parse
        xml = get_feed
        parse_feed(xml)
      end

      private

      def get_feed
        Nokogiri::XML(open(ENDPOINT))
      end

      def parse_feed(xml)
        xml.search('item').each_with_object([]) do |doc_item, accm|
          accm << record(doc_item)
        end
      end

      def record(doc_item)
        CD::Item.new({
          from: self.to_s.split('::').last.downcase,
          title: doc_item.at('title').text,
          description: doc_item.at('description').text.strip!,
          link: doc_item.at('link').text,
          comments: doc_item.at('link').text.gsub(/click\//, ''),
          updated_at: updated_at(doc_item),
          link_to_comments: doc_item.at('link').text.gsub(/click\//, ''),
          link_host: 'arstechnica.com'
        })
      end

      def updated_at(doc_item)
        unless doc_item.at('pubDate').nil?
          DateTime.parse(doc_item.at('pubDate').text).new_offset(0)
        end
      end

    end

  end
end