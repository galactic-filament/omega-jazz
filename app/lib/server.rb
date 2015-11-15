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
    payload = request.body.read
    body = JSON.parse payload
    body.to_json
  end
end
