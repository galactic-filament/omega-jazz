require File.expand_path '../test_helper', __FILE__
require 'minitest/autorun'
require 'rack/test'
require 'json'
require File.expand_path '../../lib/server', __FILE__

class UserRoutesTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelper::Methods

  def app
    Server
  end

  def test_user_create
    request_body = {email: 'a@a.a', password: 'test'}
    post '/users', request_body.to_json

    assert_equal 201, last_response.status

    response_body = JSON.parse last_response.body
    assert response_body['id'].is_a? Numeric
    assert request_body[:email], response_body['email']
  end
end
