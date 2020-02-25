require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment


namespace :resque do
  task :setup do
    require 'resque'

    ENV['QUEUE'] = '*'

    Resque.redis = $redis
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_scheduler.yml'))
  end

  task :scheduler => :setup_schedule
end

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"