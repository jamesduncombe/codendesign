# test_helper.rb
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

require_relative '../aggregator'