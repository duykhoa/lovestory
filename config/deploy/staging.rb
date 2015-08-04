set :stage, :staging
set :deploy_to, '/home/deploy/lovestory'

server 'deploy.tenluaweb.com', user: 'deploy', roles: %w{web app db}
