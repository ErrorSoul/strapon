namespace :sitemaps do
  task :create_symlink do 
	on roles(:app) do 
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "sitemap:generate"
          execute "mkdir -p #{shared_path}/sitemaps"
          execute "rm -rf #{release_path}/public/sitemaps"
          execute "ln -s #{shared_path}/sitemaps #{release_path}/public/sitemaps"
        end
      end
    
      
    #run "mkdir -p #{shared_path}/sitemaps"
    #run "rm -rf #{release_path}/public/sitemaps"
    #run "ln -s #{shared_path}/sitemaps #{release_path}/public/sitemaps"
   end	
  end
end
