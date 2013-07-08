module CD
  module Cache

    def cache(key_name, options = {}, &block)
      @client ||= IronCache::Client.new
      @cache_store ||= @client.cache(IRON_CACHE)
      if @cache_store.get(key_name)
        puts 'cache hit'
      else
        puts 'cache miss'
        @cache_store.put(key_name, yield, options)
      end
      @cache_store.get(key_name).value
    end

  end
end