require_relative '../test_helper.rb'

require 'rss'

describe CD::Rss do

  describe '#get_feed' do
    it 'returns an RSS feed of the items' do
      @items = CD::Parse.get_feeds
      p CD::Rss.new({ feed_items: @items }).get_rss
    end
  end

end