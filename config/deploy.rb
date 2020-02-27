# config valid only for current version of Capistrano


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# REMOVED: :rails_env now set in stage files.

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
# set :linked_files, fetch(:linked_files, []).push('config/production.sphinx.conf')

# Default value for linked_dirs is []
#set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'config/eye')
# set :linked_files, fetch(:linked_files, []).push('config/eye/production.eye')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# eye config
# set :eye_roles, -> { :app }
# set :eye_env, -> { { rails_env: fetch(:rails_env) } }
# set :eye_config_file, -> { "#{shared_path}/eye/#{fetch :rails_env}.eye" }

# # eye namespace
# namespace :eye do

#   task :start do
#     on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
#       within current_path do
#         with fetch(:eye_env) do
#           execute :bundle, "exec eye start m4m"
#         end
#       end
#     end
#   end

#   task :stop do
#     on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
#       within current_path do
#         with fetch(:eye_env) do
#           execute :bundle, "exec eye stop m4m"
#         end
#       end
#     end
#   end

#   task :restart do
#     on roles(fetch(:eye_roles)), in: :groups, limit: 3, wait: 10 do
#       within current_path do
#         with fetch(:eye_env) do
#           execute :bundle, "exec eye restart m4m"
#         end
#       end
#     end
#   end

#   desc "Start eye with the desired configuration file"
#   task :load_config do
#     on roles(fetch(:eye_roles)) do
#       within current_path do
#         with fetch(:eye_env) do
#           execute :bundle, "exec eye load #{fetch(:eye_config_file)}"
#         end
#       end
#     end
#   end

# end

# random task
# desc 'Invoke a rake command on the remote server'
# task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
#   on primary(:app) do
#     within current_path do
#       with :rails_env => fetch(:rails_env) do
#         rake args[:command]
#       end
#     end
#   end
# end

# deploy namespace
# namespace :deploy do

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   # desc 'Restart Resque workers'
#   # task :restart_resque do
#   #   invoke 'resque:restart'
#   # end
#   #
#   # desc 'Restart Resque Scheduler'
#   # task :restart_resque_scheduler do
#   #   invoke 'resque:scheduler:restart'
#   # end
#   #
#   # desc 'Stop Sphinx, regenerate its config and restart it'
#   # task :sphinx_setup do
#   #   on roles(:app), in: :sequence do
#   #     invoke 'thinking_sphinx:stop'
#   #     invoke 'thinking_sphinx:configure'
#   #     invoke 'thinking_sphinx:start'
#   #   end
#   # end

#   after :publishing, :restart
#   # after :restart, :restart_resque
#   # after :restart_resque, :restart_resque_scheduler
#   # after :restart_resque_scheduler, :sphinx_setup
# end

#before "deploy:restart", "eye:load_config"

# Restart all services - especially Resque or it will use old templates!

#after "deploy:restart", "eye:restart"
