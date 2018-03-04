require 'json'
require 'warden'
require File.expand_path '../base', __FILE__
require File.expand_path '../models/user', __FILE__

class UsersRoutes < Base
  post '/users' do
    content_type :json
    status 400

    parsed_body = JSON.parse(request.body.read)
    user = User.new({
      email: parsed_body['email']
    })
    user.password = parsed_body['password']
    return if user.valid? == false

    status 201
    user.save!
    user.to_json only: [:id, :email]
  end

  get '/user/:id' do
    content_type :json

    User.find(params['id']).to_json only: [:id, :email]
  end

  delete '/user/:id' do
    content_type :json

    User.destroy(params['id'])
  end

  put '/user/:id' do
    content_type :json

    parsed_body = JSON.parse(request.body.read)
    user = User.find params['id']
    user.email = parsed_body['email']
    user.password = parsed_body['password']
    user.save!
    user.to_json only: [:id, :email]
  end

  post '/login' do
    env['warden'].authenticate!
    {'authenticated': true}.to_json
  end

  get '/logout' do
    if env['warden'].user == nil
      status 403

      return {}.to_json
    end

    env['warden'].raw_session.inspect
    env['warden'].logout
    {}.to_json
  end

  post '/unauthenticated' do
    status 401
    {'authenticated': false, 'reason': env['warden.options'][:message]}.to_json
  end

  get '/user' do
    env['warden'].authenticate!
    env['warden'].user.to_json only: [:id, :email]
  end
end
