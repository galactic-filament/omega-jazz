require 'minitest/autorun'
require 'rack/test'
require 'json'
require File.expand_path '../../lib/server', __FILE__
require File.expand_path '../test_helper', __FILE__

class PostRoutesTest < MiniTest::Test
  include Rack::Test::Methods
  include TestHelper::Methods

  def app
    Server
  end

  def test_post_create
    body = { body: 'Hello, world!' }
    _create_post body
  end

  def test_post_get
    # creating the post
    body = { body: 'Hello, world!' }
    create_response_body = _create_post body

    # fetching it
    id = create_response_body['id']
    get_response_body = _test_get_json "/post/#{id}"
    assert_equal create_response_body['body'], get_response_body['body']
  end

  def test_post_delete
    # creating the post
    body = { body: 'Hello, world!' }
    create_response_body = _create_post body

    # deleting it
    id = create_response_body['id']
    delete "/post/#{id}"

    assert last_response.ok?
  end

  def test_post_put
    # creating the post
    create_body = { body: 'Hello, world!' }
    create_response_body = _create_post create_body

    # updating it
    id = create_response_body['id']
    url = "/post/#{id}"
    put_body = { body: 'Jello, world!' }
    _test_put_json url, put_body
  end
end
