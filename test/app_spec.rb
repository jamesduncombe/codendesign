require 'test_helper.rb'
require_relative '../app.rb'

include Rack::Test::Methods
require 'json'

def app
  Sinatra::Application
end

describe "Aggregator" do

  it 'returns the homepage' do
    get '/'
    last_response.body.must_match 'Code &amp; Design'
  end

  it 'returns a json feed' do
    get '/feed.json'
    JSON.parse(last_response.body).class.must_equal Array
  end

end