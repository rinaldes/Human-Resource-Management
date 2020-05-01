set :application, 'hrm'
set :repo_url, 'git@117.54.13.28:root/hrm.git'

set :deploy_to, '/home/hrm/hrm'

set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Create captcha folder'
  task :create_captcha do
    on roles(:app), in: :sequence, wait: 5 do
	    execute :mkdir, release_path.join('public/images/captcha')
  	end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

  after :restart, :create_captcha
end