require 'sinatra/base'
require 'json'

class Server < Sinatra::Base
  get '/' do
    'Hello, world!'
  end

  get '/ping' do
    'Pong'
  end

  post '/reflection' do
    content_type :json

    body = JSON.parse request.body.read
    body.to_json
  end
end
