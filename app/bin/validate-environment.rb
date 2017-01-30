require 'socket'

# validating that env vars are available
env_var_names = [
  'APP_PORT',
  'APP_LOG_DIR',
  'DATABASE_HOST'
]
env_vars = env_var_names.zip(env_var_names.map { |name| ENV[name] }).to_h
missing_env_vars = env_vars.select { |key, value| value == nil || value.length == 0 }
if missing_env_vars.length > 0
  missing_env_vars.each do |name, value|
    puts "#{name} was missing"
  end

  exit 1
end

# validating that the database port is accessible
db_port = 5432
begin
  s = TCPSocket.open env_vars['DATABASE_HOST'], db_port
  s.close
rescue SocketError
  puts "Host #{env_vars['DATABASE_HOST']} could not be found"

  exit 1
rescue Errno::ECONNREFUSED
  puts "#{env_vars['DATABASE_HOST']} was not accessible at #{db_port}"

  exit 1
end

# validating that the log dir exists
if File.exists?(env_vars['APP_LOG_DIR']) == false
  puts "#{env_vars['APP_LOG_DIR']} log dir does not exist"
  exit 1
end

exit 0