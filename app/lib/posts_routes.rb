require 'sinatra/base'
require 'json'
require 'active_record'

class Post < ActiveRecord::Base
end

class PostsRoutes < Sinatra::Base
  post '/posts' do
    content_type :json

    request_body = JSON.parse request.body.read
    post = Post.create(body: request_body['body'])
    post.to_json
  end

  get '/post/:id' do
    Post.find(params['id']).to_json
  end

  delete '/post/:id' do
    Post.destroy(params['id'])
  end
end
