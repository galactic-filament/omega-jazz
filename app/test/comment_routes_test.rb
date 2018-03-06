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
end
