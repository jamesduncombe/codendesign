require './app.rb'

memcache_servers = 'localhost'
use Rack::Cache,
verbose: true,
metastore:   "memcached://#{memcache_servers}",
entitystore: "memcached://#{memcache_servers}"

run Sinatra::Application
