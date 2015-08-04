set :stage, :production
set :deploy_to, '/home/deploy/lovestory_production'

set :rvm_ruby_version, '2.2.2@lovestory.space_production'

server 'deploy.tenluaweb.com', user: 'deploy', roles: %w{web app db}
