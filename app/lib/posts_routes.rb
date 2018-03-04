require 'json'
require File.expand_path '../base', __FILE__
require File.expand_path '../models/post', __FILE__

class PostsRoutes < Base
  post '/posts' do
    content_type :json
    status 400

    post = Post.create(body: JSON.parse(request.body.read)['body'])
    return if post.valid? == false

    status 201
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

    post = Post.find params['id']
    post.update body: JSON.parse(request.body.read)['body']
    post.to_json
  end
end
