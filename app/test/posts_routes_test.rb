require File.expand_path '../test_helper', __FILE__
require 'minitest/autorun'
require 'rack/test'
require 'json'
require File.expand_path '../../lib/server', __FILE__

class PostRoutesTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelper::Methods

  def app
    Server
  end

  def test_post_create
    post '/posts', {body: 'Hello, world!'}.to_json

    assert_equal last_response.status, 201

    response_body = JSON.parse last_response.body
    assert response_body['id'].is_a? Numeric
  end

  def test_post_create_erroneous
    post '/posts', {}.to_json

    assert_equal last_response.status, 400
  end

  def test_post_get
    create_response_body = _create_post({body: 'Hello, world!'})

    get "/post/#{create_response_body['id']}"

    assert_equal last_response.status, 200

    get_response_body = JSON.parse last_response.body
    assert_equal create_response_body['body'], get_response_body['body']
  end

  def test_post_delete
    create_response_body = _create_post({body: 'Hello, world!'})

    delete "/post/#{create_response_body['id']}"

    assert last_response.ok?
  end

  def test_post_put
    create_response_body = _create_post({body: 'Hello, world!'})

    put_request_body = {body: 'Jello, world!'}
    put "/post/#{create_response_body['id']}", put_request_body.to_json

    assert last_response.ok?

    put_response_body = JSON.parse last_response.body
    assert_equal put_response_body['body'], put_response_body['body']
  end
end
