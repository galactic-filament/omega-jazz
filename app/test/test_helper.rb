module TestHelper
  module Methods
    def _test_json ()
      status = last_response.status
      error = last_response.errors.split("\n").first
      assert last_response.ok?, "Message was not 200 OK: #{status}\n#{error}"

      JSON.parse last_response.body
    end

    def _test_get_json (url)
      get url
      _test_json
    end

    def _test_post_json (url, body)
      post url, body.to_json
      _test_json
    end

    def _test_put_json (url, body)
      put url, body.to_json
      _test_json
    end

    def _create_post(body)
      response_body = _test_post_json '/posts', body
      assert response_body['id'].is_a? Numeric
      response_body
    end
  end
end
