namespace :sitemaps do
  task :create_symlink do 
	on roles(:app) do 
    run "rake sitemap:generate"
    #run "mkdir -p #{shared_path}/sitemaps"
    #run "rm -rf #{release_path}/public/sitemaps"
    #run "ln -s #{shared_path}/sitemaps #{release_path}/public/sitemaps"]
   end	
  end
end
