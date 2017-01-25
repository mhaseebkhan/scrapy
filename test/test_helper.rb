ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |c|
    c.cassette_library_dir = 'test/cassettes'
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
  end

  MinitestVcr::Spec.configure!

  # Add more helper methods to be used by all tests here...
end
