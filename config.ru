require './config/environment'
require 'sinatra/base'
$LOAD_PATH.unshift File.expand_path(".", "app")

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

puts $LOAD_PATH
use Rack::MethodOverride
use UserController
use CourseController
use CourseDetailController
use BackEndManageController
use UserProfileController
use CategoryController
run ApplicationController
