# frozen_string_literal: true

namespace :config_files do
  desc 'Upload yml files inside config folder'
  task :upload do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"

      upload! StringIO.new(File.read('config/mongoid.yml')), "#{shared_path}/config/mongoid.yml"
      upload! StringIO.new(File.read('config/master.key')), "#{shared_path}/config/master.key"
      # upload! StringIO.new(File.read('config/application.yml')), "#{shared_path}/config/application.yml"
    end
  end
end
