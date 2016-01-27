require 'sinatra/base'
require 'json'
require 'active_record'

host = 'db'
if ENV['ENV'] == 'travis'
  host = 'localhost'
end
ActiveRecord::Base.establish_connection("postgres://postgres@#{host}/postgres")

class Post < ActiveRecord::Base
end

class Server < Sinatra::Base
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

  post '/posts' do
    content_type :json

    request_body = JSON.parse request.body.read
    post = Post.create(body: request_body['body'])
    post.to_json
  end

  get '/post/:id' do
    Post.find(params['id']).to_json
  end
end
