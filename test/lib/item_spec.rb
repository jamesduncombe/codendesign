require_relative '../test_helper.rb'

describe Item do

  let(:item) do
    Item.new(
      from: 'hacker',
      title: 'This is a title',
      description: 'This is a description',
      link: 'http://sdsdf.com',
      comments: 'http://comments.com',
      updated_at: "Sat, 30 Mar 2013 17:11:39 +0000"
    )
  end

  describe '#link_to_article' do
    it { item.link_to_article.must_equal 'http://sdsdf.com' }
  end

  describe '#link_to_comments' do
    it { item.link_to_comments.must_equal 'http://comments.com' }
  end

  describe '#link_host' do
    it { item.link_host.must_equal 'sdsdf.com' }
  end

  describe '#tweet' do
    it 'returns a tweet' do
      item
      item.tweet.must_equal "This is a title - #{item.link_to_article} via @hackernews"
    end
  end

  describe '#to_hash' do
    it 'converts the item into a hash' do
      item.to_hash.class.must_equal Hash
    end
    it 'correct serializes' do
      item.to_hash['from'].must_equal 'hacker'
    end
  end

end