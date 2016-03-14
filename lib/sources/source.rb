module Sources
  module Source
    def get_feed
      Nokogiri::XML(open(ENDPOINT))
    end

    def parse_feed(xml)
      xml.search('item').each_with_object([]) do |doc_item, accm|
        accm << record(doc_item)
      end
    end

    def record
      # noop
    end
  end
end