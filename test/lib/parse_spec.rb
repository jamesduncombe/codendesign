require_relative '../test_helper.rb'

describe CD::Parse do

  describe '#self.get_feeds' do
    it 'returns an array of all the feed data' do
      data = CD::Parse.get_feeds
      data.class.must_equal Array
    end
  end

  describe '#md5' do
    it 'returns a md5 for the etag using the array of items' do
      data =  CD::Parse.get_feeds
      puts CD::Parse.md5(data)
    end
  end

end