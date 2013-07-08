module CD
  module Cache

    def cache(key_name, options = {}, &block)
      #@client ||= IronCache::Client.new
      #@cache_store ||= @client.cache(IRON_CACHE)
      @cache_store ||= Dalli::Client.new(
        ENV['MEMCACHIER_SERVERS'],
        { expires_in: 3600, username: ENV['MEMCACHIER_USERNAME'], password: ENV['MEMCACHIER_PASSWORD'] })
      if @cache_store.get(key_name)
        puts 'cache hit'
      else
        puts 'cache miss'
        @cache_store.set(key_name, yield)
      end
      @cache_store.get(key_name)
    end

  end
end