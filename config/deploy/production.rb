# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# role :app, %w{52.207.236.3}
# role :web, %w{52.207.236.3}
# role :db,  %w{ubuntu@52.207.236.3}

server '34.201.38.42', user: 'deploy', roles: %w{app web db}

# set :server_name, '52.207.236.3'
set :branch, 'master'
set :deploy_to, '/home/deploy/m4m/apps/m4m'
set :user, 'deploy'
set :tmp_dir, '/home/deploy/m4m/tmp'
set :rails_env, 'production'

set :eye_env, -> { { rails_env: fetch(:rails_env) } }

# For Resque
role :resque_worker, "34.201.38.42"
role :resque_scheduler, "34.201.38.42"
set :workers, { "*" => 1 }

set :resque_environment_task, true

set :ssh_options, {
  forward_agent: true
  # keys: "/Users/zeeshan-imran/Downloads/production.pem"
}

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
