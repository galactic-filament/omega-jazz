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
    request_body = {email: 'a+create@a.a', password: 'test'}
    post '/users', request_body.to_json

    assert_equal 201, last_response.status

    response_body = JSON.parse last_response.body
    assert response_body['id'].is_a? Numeric
    assert request_body[:email], response_body['email']
  end

  def test_user_get
    create_response_body = _create_user email: 'a+get@a.a', password: 'test'

    get "/user/#{create_response_body['id']}"

    assert_equal last_response.status, 200

    get_response_body = JSON.parse last_response.body
    assert_equal create_response_body['email'], get_response_body['email']
  end

  def test_user_delete
    create_response_body = _create_user email: 'a+delete@a.a', password: 'test'

    delete "/user/#{create_response_body['id']}"

    assert 200, last_response.status
  end

  def test_user_put
    create_response_body = _create_user email: 'a+put@a.a', password: 'test2'

    put_request_body = {email: 'b@b.b'}
    put "/user/#{create_response_body['id']}", put_request_body.to_json

    assert_equal 200, last_response.status

    put_response_body = JSON.parse last_response.body
    assert_equal put_request_body[:email], put_response_body['email']
  end

  def test_user_login
    create_response_body = _create_user email: 'a+login@a.a', password: 'test'

    login_request_body = {email: 'a+login@a.a', password: 'test'}
    post '/login', login_request_body

    assert_equal 200, last_response.status
    assert_equal({'authenticated': true}.to_json, last_response.body)
  end

  def test_user_invalid_login_email
    login_request_body = {email: 'a+invalid-login@a.a', password: 'test'}
    post '/login', login_request_body

    assert_equal 401, last_response.status
    assert_equal({'authenticated': false, 'reason': 'Invalid email'}.to_json, last_response.body)
  end

  def test_user_invalid_login_password
    create_response_body = _create_user email: 'a+login-invalid-password@a.a', password: 'test'

    login_request_body = {email: 'a+login-invalid-password@a.a', password: 'test2'}
    post '/login', login_request_body

    assert_equal 401, last_response.status
    assert_equal({'authenticated': false, 'reason': 'Invalid password'}.to_json, last_response.body)
  end

  def test_user_data
    create_response_body = _create_user email: 'a+user-data@a.a', password: 'test'

    login_request_body = {email: 'a+user-data@a.a', password: 'test'}
    post '/login', login_request_body

    assert_equal 200, last_response.status

    get '/user'
    assert_equal 200, last_response.status

    user_response_body = JSON.parse last_response.body
    assert_equal 'a+user-data@a.a', user_response_body['email']
  end

  def test_user_data
    get '/user'
    assert_equal 401, last_response.status

    user_response_body = JSON.parse last_response.body
    assert_equal({'authenticated': false, 'reason': nil}.to_json, last_response.body)
  end

  def test_user_logout
    create_response_body = _create_user email: 'a+logout@a.a', password: 'test'

    login_request_body = {email: 'a+logout@a.a', password: 'test'}
    post '/login', login_request_body

    assert_equal 200, last_response.status
    assert_equal({'authenticated': true}.to_json, last_response.body)

    get '/logout'
    assert_equal 200, last_response.status
    assert_equal({}.to_json, last_response.body)
  end

  def test_user_logout_nonuser
    get '/logout'
    assert_equal 403, last_response.status
    assert_equal({}.to_json, last_response.body)
  end
end
