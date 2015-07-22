set :application, 'lovestory'
set :repo_url, 'git@github.com:duykhoa/lovestory.git'

set :deploy_to, '/home/deploy/lovestory'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :linked_files, %w{config/database.yml config/secrets.yml config/application.yml}

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
end
