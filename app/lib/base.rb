require 'sinatra/base'

class Base < Sinatra::Base
  ::Logger.class_eval { alias :write :'<<' }

  # access logging
  access_logger = ::Logger.new(::File.join(ENV['APP_LOG_DIR'], 'app.log'))

  # configuration
  configure do
    use ::Rack::CommonLogger, access_logger

    # do not use internal middleware for presenting errors as useful html pages
    set :show_exceptions, false

    # do not dump to stdout, error handler will log errors
    set :dump_errors, false

    # do not throw errors up the stack, errors will stop at the error handler
    set :raise_errors, false
  end

  # error handling
  error do
    status 500
    e = env['sinatra.error']
    {
      url: request.url,
      ip: request.ip,
      backtrace: e.backtrace,
      message: e.message
    }.to_json
  end
end
