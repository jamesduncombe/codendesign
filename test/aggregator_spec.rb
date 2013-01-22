require 'test_helper.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Aggregator" do
  
  it 'returns the homepage' do
    get '/'
    last_response.body.must_match 'Code &amp; Design'
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

  it 'returns the correct external link depending on the feed' do
    feed = 'https://news.layervault.com/?format=rss'
    items = parse_xml(feed)
    items.first.link_to_article.class.must_equal String
  end

  it 'returns the correct comments link' do
    feed = 'https://news.layervault.com/?format=rss'
    items = parse_xml(feed)
    items.first.link_to_comments.must_match 'layervault'
  end

end