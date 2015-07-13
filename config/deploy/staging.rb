set :stage, :staging

server 'deploy.tenluaweb.com', user: 'deploy', roles: %w{web app db}
