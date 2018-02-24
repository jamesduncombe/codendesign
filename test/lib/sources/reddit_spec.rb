require_relative '../../test_helper.rb'

describe Sources::Reddit do

  describe 'get_feed' do
    it 'gets the feed' do
      Sources::Reddit.parse.class.must_equal Array
    end
  end
end
