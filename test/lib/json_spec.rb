require_relative '../test_helper.rb'

require 'json'

describe CD::Json do

  describe '#get_feed' do
    it 'returns an RSS feed of the items' do
      @items = CD::Parse.get_feeds
      p CD::Json.new({ feed_items: @items }).get_json
    end
  end

end