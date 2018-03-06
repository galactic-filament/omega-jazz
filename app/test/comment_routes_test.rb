require File.expand_path '../test_helper', __FILE__
require 'minitest/autorun'
require 'rack/test'
require 'json'
require File.expand_path '../../lib/server', __FILE__

class CommentRoutesTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelper::Methods

  def app
    Server
  end

  def test_comment_create
    post_response_body = _create_post body: 'Hello, world!'

    password = 'test'
    user_response_body = _create_user email: 'a+comment-create@a.a', password: password
    post('/login', {email: user_response_body['email'], password: password})

    post "/post/#{post_response_body['id']}/comments", {body: 'Hello, world!'}.to_json
    assert_equal 201, last_response.status
  end

  def test_comment_create_invalid_post
    password = 'test'
    user_response_body = _create_user email: 'a+comment-create-invalid-post@a.a', password: password
    post('/login', {email: user_response_body['email'], password: password})

    post '/post/-1/comments', {body: 'Hello, world!'}.to_json
    assert_equal 404, last_response.status
  end

  def test_comment_create_unauthenticated
    post '/post/-1/comments', {body: 'Hello, world!'}.to_json
    assert_equal 401, last_response.status
  end

  def test_comment_get
    post_response_body = _create_post body: 'Hello, world!'

    password = 'test'
    user_response_body = _create_user email: 'a+comment-get@a.a', password: password
    post('/login', {email: user_response_body['email'], password: password})

    comment_response_body = _create_comment post_response_body, body: 'Hello, world!'

    get "/comment/#{comment_response_body['id']}"
    assert_equal 200, last_response.status
  end

  def test_comment_destroy
    post_response_body = _create_post body: 'Hello, world!'

    password = 'test'
    user_response_body = _create_user email: 'a+comment-destroy@a.a', password: password
    post('/login', {email: user_response_body['email'], password: password})

    comment_response_body = _create_comment post_response_body, body: 'Hello, world!'

    delete "/comment/#{comment_response_body['id']}"
    assert_equal 200, last_response.status
  end

  def test_comment_update
    post_response_body = _create_post body: 'Hello, world!'

    password = 'test'
    user_response_body = _create_user email: 'a+comment-destroy@a.a', password: password
    post('/login', {email: user_response_body['email'], password: password})

    comment_response_body = _create_comment post_response_body, body: 'Hello, world!'

    put_request_body = {body: 'Jello, world!'}
    put "/comment/#{comment_response_body['id']}", put_request_body.to_json

    assert_equal 200, last_response.status

    put_response_body = JSON.parse last_response.body
    assert_equal put_request_body[:body], put_response_body['body']
  end
end
