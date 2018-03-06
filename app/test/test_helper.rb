require 'coveralls'
Coveralls.wear!

module TestHelper
  module Methods
    def _test_json(status=200)
      error = last_response.errors.split("\n").first
      assert last_response.status == status, "Message was not #{status}: #{last_response.status}\n#{error}"

      JSON.parse last_response.body
    end

    def _test_get_json(url, status=200)
      get url
      _test_json status
    end

    def _test_post_json(url, body, status=200)
      post url, body.to_json
      _test_json status
    end

    def _test_put_json(url, body, status=200)
      put url, body.to_json
      _test_json status
    end

    def _create_post(body)
      response_body = _test_post_json '/posts', body, 201
      assert response_body['id'].is_a? Numeric
      response_body
    end

    def _create_user(body)
      response_body = _test_post_json '/users', body, 201
      assert response_body['id'].is_a? Numeric
      response_body
    end

    def _create_comment(post, body)
      response_body = _test_post_json "/post/#{post['id']}/comments", body, 201
      assert response_body['id'].is_a? Numeric
      response_body
    end
  end
end
