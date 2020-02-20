
set :staging, :staging
server '34.204.53.212', user: 'ubuntu', roles: %w{app web db}

set :ssh_options, {
    forward_agent: true
}
set :branch, 'staging'
set :rvm_ruby_version, 'ruby-2.3.0@m4m'
# set :rvm_custom_path, '/home/root/.rvm'
set :deploy_to, '/home/app'

