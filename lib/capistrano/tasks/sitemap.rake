namespace :sitemaps do
  task :create_symlink, roles: :app do
    run "mkdir -p #{shared_path}/sitemaps"
    run "rm -rf #{release_path}/public/sitemaps"
    run "ln -s #{shared_path}/sitemaps #{release_path}/public/sitemaps"
  end
end
