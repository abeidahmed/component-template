source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3', '>= 4.3.6'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'front_matter_parser'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'friendly_id', '~> 5.4.0'
gem 'bcrypt', '~> 3.1', '>= 3.1.16'

group :development, :test do
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
