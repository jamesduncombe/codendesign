require 'json'

module CD
  class Json

    def self.get_json(feed_items)
      feed_items
        .each_with_object([]) { |item, accm| accm << item.to_hash }
        .to_json
    end

  end
end