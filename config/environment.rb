ENV['SINATRA_ENV'] ||= 'development'
ENV['SESSION_SECRET'] = 'Oq<dDrr=C1~pI*]MK:q:'

require 'bundler/setup'
require 'rack-flash'
Bundler.require()

configure :development do
  # set :database, 'sqlite:///dev.db'
  # set :show_exceptions, true
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :show_exceptions => true,
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end
 
configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

require_all 'app'