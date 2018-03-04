require 'sinatra/base'

class Base < Sinatra::Base
  ::Logger.class_eval { alias :write :'<<' }

  # access logging
  access_logger = ::Logger.new(::File.join(ENV['APP_LOG_DIR'], 'app.log'))
  configure do
    use ::Rack::CommonLogger, access_logger
  end

  # error handling
  disable :show_exceptions
  set :show_exceptions, false
  error do
    {message: env['sinatra.error'].message}.to_json
  end
end
