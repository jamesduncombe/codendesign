require_relative '../../test_helper.rb'

describe Sources::HackerNews do

  describe 'get_feed' do
    it 'gets the feed' do
      Sources::HackerNews.parse.class.must_equal Array
    end
  end
end