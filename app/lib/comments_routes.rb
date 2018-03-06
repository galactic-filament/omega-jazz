require 'json'
require File.expand_path '../base', __FILE__
require File.expand_path '../models/post', __FILE__
require File.expand_path '../models/comment', __FILE__

class CommentsRoutes < Base
  post '/post/:id/comments' do
    env['warden'].authenticate!

    content_type :json

    post = Post.find(params['id'])
    if post == nil
      status 404

      return {}.to_json
    end

    comment = Comment.create({
      body: JSON.parse(request.body.read)['body'],
      user: env['warden'].user,
      post: post
    })

    status 201
    comment.to_json
  end
end
