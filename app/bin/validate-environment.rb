require 'socket'

# validating that env vars are available
env_var_names = [
  'APP_PORT',
  'APP_LOG_DIR',
  'DATABASE_HOST'
]
env_var_values = env_var_names.map { |name| ENV[name] }
env_vars = Hash[env_var_names.zip(env_var_values)]
missing_env_vars = env_vars.reject { |key, value| value == nil || value.length == 0 }
if missing_env_vars.length > 0
  missing_env_vars.each do |name, value|
    puts "#{name} was missing"
  end
  exit 1
end

# validating that the database port is accessible
db_port = 5432
begin
  s = TCPSocket.open(env_vars['DATABASE_HOST'], db_port)
  s.close
rescue SocketError
  puts "Host #{env_vars['DATABASE_HOST']} could not be found"
  exit 1
rescue Errno::ECONNREFUSED
  puts "#{env_vars['DATABASE_HOST']} was not accessible at #{db_port}"
  exit 1
end

exit 0