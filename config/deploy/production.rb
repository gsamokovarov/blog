set :rails_env, 'production'

# Setup rbenv.
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

# No --deployment flags because of conflicting rolling-restart.
set :bundle_flags, '--quiet'
set :bundle_path, nil

set :linked_dirs, %w(tmp/pids tmp/sockets log public/assets)

server 'localhost:2222', user: 'vagrant'
