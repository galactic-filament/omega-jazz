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

    JSON.parse(request.body.read).to_json
  end
end
