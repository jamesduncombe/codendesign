require_relative '../../test_helper.rb'

describe Sources::ArsSecurity do

  describe 'get_feed' do
    it 'gets the feed' do
      Sources::ArsSecurity.parse.class.must_equal Array
    end
  end
end