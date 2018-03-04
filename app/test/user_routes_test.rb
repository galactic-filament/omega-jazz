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

  def test_user_get
    create_response_body = _create_user email: 'a@a.a', password: 'test'

    get "/user/#{create_response_body['id']}"

    assert_equal last_response.status, 200

    get_response_body = JSON.parse last_response.body
    assert_equal create_response_body['email'], get_response_body['email']
  end

  def test_user_delete
    create_response_body = _create_user email: 'a@a.a', password: 'test'

    delete "/user/#{create_response_body['id']}"

    assert last_response.ok?
  end

  def test_user_put
    create_response_body = _create_user email: 'a@a.a', password: 'test2'

    put_request_body = {email: 'b@b.b'}
    put "/user/#{create_response_body['id']}", put_request_body.to_json

    assert_equal last_response.status, 200

    put_response_body = JSON.parse last_response.body
    assert_equal put_request_body[:email], put_response_body['email']
  end
end
