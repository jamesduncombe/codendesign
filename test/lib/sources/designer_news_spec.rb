require_relative '../../test_helper.rb'

describe Sources::DesignerNews do

  describe 'get_feed' do
    it 'gets the feed' do
      Sources::DesignerNews.parse.class.must_equal Array
    end
  end
end