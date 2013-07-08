module CD
  class Json

    def initialize(args = {})
      @feed_items = args[:feed_items]
    end

    def get_json
      h = []

      @feed_items.each do |i|
        h << i.to_hash
      end

      h.to_json
    end

  end
end