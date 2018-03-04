require File.expand_path '../test_helper', __FILE__
require 'minitest/autorun'
require 'rack/test'
require 'json'
require File.expand_path '../../lib/server', __FILE__

class DefaultRoutesTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelper::Methods

  def app
    Server
  end

  def test_hello_world
    get '/'
    assert last_response.ok?
    assert_equal 'Hello, world!', last_response.body
  end

  def test_ping
    get '/ping'
    assert last_response.ok?
    assert_equal 'Pong', last_response.body
  end

  def test_reflection
    body = { greeting: 'Hello, world!' }
    post '/reflection', body.to_json
    assert last_response.status == 200

    response_body = JSON.parse last_response.body
    assert_equal body[:greeting], response_body['greeting']
  end

  def test_error
    get '/error'
    assert_equal 500, last_response.status
    assert_equal({'message': 'Test'}.to_json, last_response.body)
  end
end
