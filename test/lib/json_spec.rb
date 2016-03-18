require_relative '../test_helper.rb'

describe CD::Json do

  describe '#get_feed' do
    it 'returns an RSS feed of the items' do
      items = CD::Parse.get_feeds
      p CD::Json.get_json(items)
    end
  end

end