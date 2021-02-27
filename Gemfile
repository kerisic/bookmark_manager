source 'https://rubygems.org'

group :test, :development, :production do
  gem 'pg'
  gem 'rack'
  gem 'sinatra'
  gem 'uri'
  gem 'bcrypt'
end

group :development, :production do
  gem 'puma'
  gem 'sinatra-flash'
end

group :test, :development do
  gem 'rake'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'capybara'
  gem 'rspec'
end
