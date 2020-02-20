# # server-based syntax
# # ======================
# # Defines a single server with a list of roles and multiple properties.
# # You can define all roles on a single server, or split them:

# # server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# # server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# # server 'db.example.com', user: 'deploy', roles: %w{db}

# role :app, %w{m4m@staging.m4m.net}
# role :web, %w{m4m@staging.m4m.net}
# role :db,  %w{m4m@staging.m4m.net}

# set :server_name, 'staging.m4m.net'

# set :branch, 'staging'
# set :rails_env, 'staging'
# set :deploy_to, '/home/m4m/apps/m4m'
# set :user, 'm4m'
# set :tmp_dir, '/home/m4m/tmp'

# # For Resque
# role :resque_worker, "staging.m4m.net"
# role :resque_scheduler, "staging.m4m.net"
# set :workers, { "mailers" => 1, 'default' => 1 }

# set :resque_environment_task, true

# set :ssh_options, {
#   forward_agent: true,
#   port: 41447,
#   keys: "#{ENV['SSH_KEY_PATH']}/m4m.pem"
# }

# # role-based syntax
# # ==================

# # Defines a role with one or multiple servers. The primary server in each
# # group is considered to be the first unless any  hosts have the primary
# # property set. Specify the username and a domain or IP for the server.
# # Don't use `:all`, it's a meta role.

# # role :app, %w{deploy@example.com}, my_property: :my_value
# # role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# # role :db,  %w{deploy@example.com}



# # Configuration
# # =============
# # You can set any configuration variable like in config/deploy.rb
# # These variables are then only loaded and set in this stage.
# # For available Capistrano configuration variables see the documentation page.
# # http://capistranorb.com/documentation/getting-started/configuration/
# # Feel free to add new variables to customise your setup.



# # Custom SSH Options
# # ==================
# # You may pass any option but keep in mind that net/ssh understands a
# # limited set of options, consult the Net::SSH documentation.
# # http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
# #
# # Global options
# # --------------
# #  set :ssh_options, {
# #    keys: %w(/home/rlisowski/.ssh/id_rsa),
# #    forward_agent: false,
# #    auth_methods: %w(password)
# #  }
# #
# # The server-based syntax can be used to override options:
# # ------------------------------------
# # server 'example.com',
# #   user: 'user_name',
# #   roles: %w{web app},
# #   ssh_options: {
# #     user: 'user_name', # overrides user setting above
# #     keys: %w(/home/user_name/.ssh/id_rsa),
# #     forward_agent: false,
# #     auth_methods: %w(publickey password)
# #     # password: 'please use keys'
# #   }



set :staging, :staging
server '34.204.53.212', user: 'ubuntu', roles: %w{app web db}

set :ssh_options, {
    forward_agent: true
}
set :branch, 'staging'
set :rvm_ruby_version, 'ruby-2.3.0@m4m'
# set :rvm_custom_path, '/home/root/.rvm'
set :deploy_to, '/home/app'


