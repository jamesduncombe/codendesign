require_relative '../../test_helper.rb'

describe Sources::TheHackerNews do

  describe 'get_feed' do
    it 'gets the feed' do
      Sources::TheHackerNews.parse.class.must_equal Array
    end
  end
end