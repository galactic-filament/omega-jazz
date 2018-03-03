require 'sinatra/base'
require 'json'
require 'active_record'

class Post < ActiveRecord::Base
  validates :body, presence: true
end

class PostsRoutes < Sinatra::Base
  post '/posts' do
    content_type :json
    status 201

    request_body = JSON.parse request.body.read
    post = Post.create(body: request_body['body'])
    if post.valid? == false
      status 400
      return
    end

    post.to_json
  end

  get '/post/:id' do
    content_type :json

    Post.find(params['id']).to_json
  end

  delete '/post/:id' do
    content_type :json

    Post.destroy(params['id'])
  end

  put '/post/:id' do
    content_type :json

    request_body = JSON.parse request.body.read
    post = Post.find(params['id'])
    post.update(body: request_body['body'])
    post.to_json
  end
end
