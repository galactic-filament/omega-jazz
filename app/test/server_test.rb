require_relative './test_helper'
require_relative '../lib/server'
require 'rack/test'

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
end
