source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record

ruby '2.0.0'

gem 'bcrypt-ruby', '3.1.2'


#puma 
gem 'puma'

gem 'haml'

gem 'carrierwave', '0.8.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

#suka suka suka
gem 'bootstrap-sass', '3.2.0.2'
gem 'font-awesome-sass', '~> 4.2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

#em "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'faker'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end


group :test do
  gem 'libnotify', '0.8.0'
  gem "capybara", '~> 2.0.3'
  gem "pry"
  
  gem 'selenium-webdriver', '2.35.1'
  
  
end



group :development do
  

  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
end
group :development, :test do
  #factory girl
  gem 'sqlite3'
  gem 'factory_girl_rails'
  
  gem "rspec-rails", '~> 2.14.0.rc1'
  gem 'minitest'
 

   # Guard
  gem 'guard-jasmine'
  gem "guard-bundler", ">= 1.0.0"
  gem "guard-rails", ">= 0.4.0"
  gem "guard-rspec", ">= 2.5.2"
  gem "rb-inotify", ">= 0.9.0", :require => false
  gem "rb-fsevent", ">= 0.9.3", :require => false
  gem "rb-fchange", ">= 0.0.6", :require => false



   # Jasmine

gem "jasmine-rails"
gem "jasmine", '~> 1.3.1'

end

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
 
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

