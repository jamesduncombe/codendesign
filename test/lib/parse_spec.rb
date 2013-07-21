require_relative '../test_helper.rb'

describe CD::Parse do

  describe '#self.feed_data' do
    it 'returns the feed data' do
      feed = CD::Parse.feed_data(CD::Parse::HACKER_NEWS)
      feed.class.must_equal Nokogiri::XML::Document
    end
  end

  describe '#self.parse_xml' do
    before(:all) do
      doc = CD::Parse.feed_data(CD::Parse::HACKER_NEWS)
      @data = CD::Parse.parse_xml(doc, CD::Parse::HACKER_NEWS)
    end
    it 'returns a nicely parsed XML array of hashes' do
      @data.class.must_equal Array
    end
    it 'item should be of class Item' do
      @data.first.class.must_equal CD::Item
    end
    it 'should have a string type for the title' do
      @data.first.title.class.must_equal String
    end
  end

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