# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# role :app, %w{52.207.236.3}
# role :web, %w{52.207.236.3}
# role :db,  %w{ubuntu@52.207.236.3}
lock '3.12.0'

server '34.201.38.42', user: 'deploy', roles: %w{app web db}

set :application, 'm4m'
set :repo_url, 'git@github.com:Hussainbhatti1/massage4men.git'
set :use_sudo, false

# set :server_name, '52.207.236.3'
set :branch, 'master'
set :deploy_to, '/home/deploy/m4m/apps/m4m'
set :user, 'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

set :tmp_dir, '/home/deploy/m4m/tmp'
set :rails_env, 'production'

set :puma_bind,       "unix:///home/deploy/m4m/apps/m4m/shared/tmp/sockets/m4m-puma.sock"
set :puma_state,      "/home/deploy/m4m/apps/m4m/shared/tmp/pids/puma.state"
set :puma_pid,        "/home/deploy/m4m/apps/m4m/shared/tmp/pids/puma.pid"
set :puma_access_log, "/home/deploy/m4m/apps/m4m/shared/log/puma_error.log"
set :puma_error_log,  "/home/deploy/m4m/apps/m4m/shared/log/puma_access.log"

set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord

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

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir home/deploy/m4m/apps/m4m/shared/tmp/sockets -p"
      execute "mkdir home/deploy/m4m/apps/m4m/shared/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end


namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end


  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
