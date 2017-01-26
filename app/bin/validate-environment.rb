require 'socket'

# validating that env vars are available
env_var_names = [
  'APP_PORT',
  'APP_LOG_DIR',
  'DATABASE_HOST'
]
env_var_values = env_var_names.map { |name| ENV[name] }
env_vars = Hash[ env_var_names.zip(env_var_values) ]
puts env_vars

# validating that the database port is accessible
begin
  s = TCPSocket.open('Db', 5433)
  s.close
rescue Errno::ECONNREFUSED
  exit 1
end

exit 0