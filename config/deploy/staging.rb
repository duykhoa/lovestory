set :stage, :staging
set :deploy_to, '/home/deploy/lovestory'

server 'deploy.lovestory.space', user: 'deploy', roles: %w{web app db}
