ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'rspec/rails'
require 'rspec/given'
require 'rspec/mocks'
require 'database_cleaner'
require 'sidekiq/testing'

RSpec.configure do |config|

  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  config.include Devise::TestHelpers, :type => :controller
end
