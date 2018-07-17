require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end
# if defined?(ActiveRecord::Migrator)
#   migrator = ActiveRecord::Migrator.new(
#     :up, ActiveRecord::Migrator.migrations_paths
#   )
  
#   if (pending = migrator.pending_migrations).any?
#     raise %Q[Attention! The following migrations are PENDING:#{pending.map(&:filename).join("\n")}Please run 'rake db:migrate db:test:prepare'...]
#   end
# end
use Rack::MethodOverride
# suse UserController
# use CourseController
run ApplicationController
