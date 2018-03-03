require 'sinatra/base'
require 'active_record'
require File.expand_path '../default_routes', __FILE__
require File.expand_path '../posts_routes', __FILE__
require File.expand_path '../users_routes', __FILE__
require 'logger'

db_host = ENV['DATABASE_HOST']
ActiveRecord::Base.establish_connection("postgres://postgres@#{db_host}/postgres")

class Server < Sinatra::Base
  use DefaultRoutes
  use PostsRoutes
  use UsersRoutes
end
