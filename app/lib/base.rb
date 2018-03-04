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
    status 500
    e = env['sinatra.error']
    {
      url: request.url,
      ip: request.ip,
      backtrace: e.backtrace.join("\n"),
      message: e.message
    }.to_json
  end
end
