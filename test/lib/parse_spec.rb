require_relative '../test_helper.rb'

describe Parse do

  # describe '#self.from' do
  #   it { Parse.from('https://news.layervault.com/?format=rss').must_equal 'design' }
  # end

  # describe '#self.link' do
  #   it { Parse.from('https://news.layervault.com/?format=rss').must_equal 'design' }
  # end

  describe '#self.feed_data' do
    it 'returns the feed data' do
      feed = Parse.feed_data(Parse::HACKER_NEWS)
      feed.class.must_equal Nokogiri::XML::Document
    end
  end

  describe '#self.parse_xml' do
    before(:all) do
      doc = Parse.feed_data(Parse::HACKER_NEWS)
      @data = Parse.parse_xml(doc, Parse::HACKER_NEWS)
    end
    it 'returns a nicely parsed XML array of hashes' do
      @data.class.must_equal Array
    end
    it 'item should be of class Item' do
      @data.first.class.must_equal Item
    end
    it 'should have a string type for the title' do
      @data.first.title.class.must_equal String
    end
  end

  describe '#self.get_feeds' do
    it 'returns an array of all the feed data' do
      data = Parse.get_feeds
      data.class.must_equal Array
    end
  end



end