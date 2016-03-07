require 'sinatra/base'
require 'active_record'
require_relative './default_routes'
require_relative './posts_routes'

db_host = ENV['DATABASE_HOST']
ActiveRecord::Base.establish_connection("postgres://postgres@#{db_host}/postgres")

class Server < Sinatra::Base
  use DefaultRoutes
  use PostsRoutes
end
