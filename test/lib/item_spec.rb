require_relative '../test_helper.rb'

describe CD::Item do

  let(:item) do
    CD::Item.new({
      from: 'hackernews',
      title: 'This is a title',
      description: 'This is a description',
      link: 'http://sdsdf.com',
      comments: 'http://comments.com',
      updated_at: DateTime.now
    })
  end

  describe '#to_hash' do
    it 'converts the item into a hash' do
      item.to_hash.class.must_equal Hash
    end
    it 'correct serializes' do
      item.to_hash[:from].must_equal 'hackernews'
    end
  end

end