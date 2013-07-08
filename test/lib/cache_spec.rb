require_relative '../test_helper.rb'

require 'iron_cache'

include CD::Cache

describe CD::Cache do

  describe '#cache' do
    it 'returns a value or sets it if it is empty from the block' do
      cache_config({ cache_store: 'test_cache' })
      val = cache('test') { 'yes yes yo' }
      val.must_equal 'yes yes yo'
    end
  end

end