require 'sinatra/base'
require 'json'

class DefaultRoutes < Sinatra::Base
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

    request_body = JSON.parse request.body.read
    request_body.to_json
  end
end
