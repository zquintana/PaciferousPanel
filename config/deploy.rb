# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'paciferous_panel'
set :repo_url, 'git@github.com:zquintana/PaciferousPanel.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/zach/www/panel.vectorw3b.com'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{
  config/database.yml
  config/initializers/devise.rb
  config/secrets.yml
}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  secret_key_base: '3c315dfe70535b887f875ab45f3d447d7ff98700c1a79cc085e0e11a192851f98f095bf4666e1e6cb7541adb94c4622a48aa3de9ba39f61d9a70a9f5b993b6fe'
}

# Default value for keep_releases is 5
# set :keep_releases, 5

# setup rvm.
set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails passenger}

set :rails_env, "production"

namespace :deploy do

  #desc 'Restart application'
  #task :restart do
  #  on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
  #    execute :touch, release_path.join('tmp/restart.txt')
  #  end
  #end

  desc 'Start application via passenger'
  task :start do
    on roles(:app) do
      within current_path do
        execute :passenger, "start --daemonize --port 8080 --environment production"
      end
    end
  end

  desc 'Stop passenger'
  task :stop do
    on roles(:app) do
      within current_path do
        execute  :passenger, "stop  --port 8080"
      end
    end
  end


  desc 'Add root scheduled tasks'
  task :root_schedules do
    # ask(:sudo_password, nil)
    on roles(:all) do 
      within release_path do
        execute :sudo, :bundle, 'exec whenever -w config/root_schedule.rb -u root'
      end
    end
  end

  after :published, :root_schedules

  after :publishing, :restart

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
  #    within release_path do
  #      execute :rake, 'cache:clear'
  #    end
  #  end
  #end



end
