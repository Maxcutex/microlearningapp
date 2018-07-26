ENV['SINATRA_ENV'] ||= 'development'
ENV['SESSION_SECRET'] = 'Oq<dDrr=C1~pI*]MK:q:'

require 'bundler/setup'
require 'rack-flash'
Bundler.require(:default, ENV['SINATRA_ENV'])

# configure :development do
#   ActiveRecord::Base.establish_connection(
#     :adapter => 'sqlite3',
#     :show_exceptions => true,
#     :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#   )
# end
configure :production, :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://microlearnadmin:MicroLearn1@localhost:5432/microlearndb')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
end

require_all 'app'
