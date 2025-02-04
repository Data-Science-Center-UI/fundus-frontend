# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.17.3'

set :application, 'fundus_frontend'
set :repo_url, 'git@github.com-fundus-frontend:Data-Science-Center-UI/fundus-frontend.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/fundus_frontend
# set :deploy_to, "/var/www/fundus_frontend"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/mongoid.yml', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/javascript', 'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# upload configuration files
before 'deploy:starting', 'config_files:upload'

# reload application after successful deploy
# after 'deploy:publishing', 'application:reload'
