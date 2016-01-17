set :stage, :staging
set :deploy_to, '/home/deploy/lovestory'
set :npm_target_path, "#{current_path}"

server 'deploy.lovestory.space', user: 'deploy', roles: %w{web app db}
