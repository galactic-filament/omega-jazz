require 'sinatra/base'
require 'json'

class DefaultRoutes < Sinatra::Base
  get '/' do
    'Hello, world!'
  end

  get '/ping' do
    'Pong'
  end

  post '/reflection' do
    content_type :json

    request_body = JSON.parse request.body.read
    request_body.to_json
  end
end
