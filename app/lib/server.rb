require 'sinatra/base'

class Server < Sinatra::Base
  get '/' do
    'Hello, world!'
  end

  get '/ping' do
    'Pong'
  end
end
