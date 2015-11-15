require_relative './test_helper'
require_relative '../lib/server'
require 'rack/test'
require 'json'

class ServerTest < MiniTest::Test
  include Rack::Test::Methods

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
    post '/reflection', { greeting: 'Hello, world!' }.to_json
    assert last_response.ok?
  end
end
