require 'sinatra/base'
require 'active_record'
require_relative './default_routes'
require_relative './posts_routes'
require 'logger'

db_host = ENV['DATABASE_HOST']
ActiveRecord::Base.establish_connection("postgres://postgres@#{db_host}/postgres")

class Server < Sinatra::Base
  ::Logger.class_eval { alias :write :'<<' }

  # access logging
  access_logger = ::Logger.new(::File.join(ENV['APP_LOG_DIR'], 'access.log'))
  configure do
    use ::Rack::CommonLogger, access_logger
  end

  # error logging
  error_log = ::File.new(::File.join(ENV['APP_LOG_DIR'], 'error.log'), "a+")
  error_log.sync = true
  before {
    env["rack.errors"] = error_log
  }

  use DefaultRoutes
  use PostsRoutes
end
