set :application, 'lovestory'
set :repo_url, 'git@github.com:duykhoa/lovestory.git'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml config/newrelic.yml}
set :linked_dirs, %w{ public/system/assets node_modules tmp public/bower_components}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 2
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
  before :updated, 'npm:bower'
end

namespace :npm do
  task :install do
    on roles(:app) do
      within fetch(:npm_target_path) do
        execute "bash -l -c '. ~/.nvm/nvm.sh && cd #{release_path} && npm install && npm install -g bower && npm install -g gulp'"
      end
    end
  end

  task :bower do
    on roles(:app) do
      within fetch(:npm_target_path) do
        execute "bash -l -c '. ~/.nvm/nvm.sh && cd #{release_path} && bower install && gulp'"
      end
    end
  end
end

set :npm_flags, ''
