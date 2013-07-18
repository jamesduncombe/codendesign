module CD
  module Cache

    def cache(key_name, options = {}, &block)
      @cache_store ||= Dalli::Client.new(
        '127.0.0.1:11211',
        { expires_in: 3600 })
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