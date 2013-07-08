# test_helper.rb
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

require_relative '../lib/item.rb'
require_relative '../lib/parse.rb'
require_relative '../lib/rss.rb'
require_relative '../lib/json.rb'
require_relative '../lib/cache.rb'