ENV['SINATRA_ENV'] = 'test'
require 'simplecov'
require 'coveralls'
SimpleCov.start
Coveralls.wear!
require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'
require "selenium/webdriver"
require 'faker'


Dir[File.join(File.dirname(__FILE__), '.', 'factories', '**/*.rb')].sort.each do |file|
  require file
end
Dir[File.join(File.dirname(__FILE__), '.', 'support', '**/*.rb')].sort.each do |file|
  require file
end

if ActiveRecord::Base.connection.migration_context.needs_migration?
  st = 'Migrations are pending. '
  art = 'Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
  start = st + art
  raise start
end

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  DatabaseCleaner.strategy = :truncation
  # config.infer_spec_type_from_file_location!
  config.before do
    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.order = 'default'
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::Wysihtml5Helper, type: :feature
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.app = app
