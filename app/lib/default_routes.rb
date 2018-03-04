require 'json'
require File.expand_path '../base', __FILE__

class DefaultRoutes < Base
  get '/' do
    content_type 'text/plain'

    'Hello, world!'
  end

  get '/ping' do
    content_type 'text/plain'

    'Pong'
  end

  post '/reflection' do
    content_type :json

    JSON.parse(request.body.read).to_json
  end

  get '/error' do
    raise 'Test'
  end
end
