ENV['SINATRA_ENV'] = 'test'
require 'simplecov'
require 'coveralls'
SimpleCov.start
Coveralls.wear!
require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

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

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
