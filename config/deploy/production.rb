set :stage, :production
set :deploy_to, '/home/deploy/lovestory_production'
set :npm_target_path, "#{current_path}"

set :rvm_ruby_version, '2.2.2@lovestory.space_production'

server 'deploy.lovestory.space', user: 'deploy', roles: %w{web app db}
