require 'sinatra/base'
require 'active_record'
require 'warden'
require File.expand_path '../base', __FILE__
require File.expand_path '../default_routes', __FILE__
require File.expand_path '../posts_routes', __FILE__
require File.expand_path '../users_routes', __FILE__
require File.expand_path '../comments_routes', __FILE__
require File.expand_path '../models/user', __FILE__

db_host = ENV['DATABASE_HOST']
ActiveRecord::Base.establish_connection("postgres://postgres@#{db_host}/postgres")

class Server < Base
  enable :sessions

  Warden::Strategies.add(:password) do
    def valid?
      params['email'] && params['password']
    end

    def authenticate!
      user = User.find_by email: params['email']
      return fail!('Invalid email') if user.nil?
      return fail!('Invalid password') if user.password != params['password']

      success!(user)
    end
  end

  use Warden::Manager do |config|
    config.serialize_into_session{|user| user.id}
    config.serialize_from_session{|id| User.find(id)}
    config.scope_defaults :default, {
      strategies: [:password],
      action: '/unauthenticated'
    }
    config.failure_app = UsersRoutes
  end

  Warden::Manager.before_failure do |env, opts|
    env['REQUEST_METHOD'] = 'POST'
    env.each do |key, value|
      env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
    end
  end

  use DefaultRoutes
  use PostsRoutes
  use UsersRoutes
  use CommentsRoutes
end
