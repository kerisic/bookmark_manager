source 'https://rubygems.org'

ruby '2.7.2'

group :development, :production do
  gem 'puma'
  gem 'sinatra-flash'
end

group :test, :development, :production do
  gem 'pg'
  gem 'rack'
  gem 'sinatra'
  gem 'uri'
  gem 'bcrypt'
end

group :test, :development do
  gem 'rake'
  gem 'rubocop', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'capybara'
  gem 'rspec'
end
