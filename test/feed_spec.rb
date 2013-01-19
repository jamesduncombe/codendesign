require 'test_helper.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Aggregator" do
  it 'returns the homepage' do
    get '/'
    last_response.body.must_match 'Aggregator'
  end

  it 'reads the XML feed' do
    feed = 'https://news.layervault.com/?format=rss'
    items = parse_xml(feed)
    item = items.first
    item.title.class.must_equal String
  end

  it 'creates an array of Item classes' do
    feed = 'https://news.layervault.com/?format=rss'
    items = parse_xml(feed)
    items.first.class.must_equal Item
  end

  it 'returns the timeago' do
    i = parse_html('https://news.layervault.com/stories')
    i.first.must_equal '11 minutes ago'
  end

end