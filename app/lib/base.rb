require 'sinatra/base'

class Base < Sinatra::Base
  ::Logger.class_eval { alias :write :'<<' }

  # access logging
  access_logger = ::Logger.new(::File.join(ENV['APP_LOG_DIR'], 'app.log'))

  # configuration
  configure do
    use ::Rack::CommonLogger, access_logger
    set :show_exceptions, false
    set :dump_errors, false
    set :raise_errors, false
  end

  # error handling
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
