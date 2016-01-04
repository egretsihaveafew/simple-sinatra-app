worker_processes 4


APP_PATH = "/var/www"
working_directory APP_PATH


listen "/var/www/.unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30

pid "/tmp/unicorn.pid"

stderr_path "/var/log/unicorn/unicorn.stderr.log"
stdout_path "/var/log/unicorn/unicorn.stdout.log"

preload_app true

check_client_connection false

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  if run_once
  end

end

after_fork do |server, worker|

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

end

