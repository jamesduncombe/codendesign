require './lib/item'

module CD::RssParser

  private

  def get_feed(endpoint, &block)
    xml = Nokogiri::XML(URI.open(endpoint))
    block.call(xml)
  rescue
    []
  end

  def parse_feed(xml, &block)
    xml.search('item').each_with_object([]) do |item, accm|
      params = block.call(item)
      accm << CD::Item.new(params.merge({
        from: self.to_s.split('::').last.downcase
      }))
    end
  end

end
