# spec/spec_helper.rb
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'


module RSpecMixin
  include Rack::Test::Methods
  def app() ApplicationController end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
