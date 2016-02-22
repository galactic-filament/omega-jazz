require 'sinatra/base'
require 'json'
require 'active_record'
require_relative './default_routes'
require_relative './posts_routes'

host = 'db'
if ENV['ENV'] == 'travis'
  host = 'localhost'
end
ActiveRecord::Base.establish_connection("postgres://postgres@#{host}/postgres")

class Post < ActiveRecord::Base
end

class Server < Sinatra::Base
  use DefaultRoutes
  use PostsRoutes
end
