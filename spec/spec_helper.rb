ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'rspec/rails'
require 'rspec/given'
require 'rspec/mocks'
require 'sidekiq'
require 'sidekiq/testing'
require 'database_cleaner'
require 'pry'


RSpec.configure do |config|

  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start

    Sidekiq::Testing.fake!
    City.create(subdomain: "newyork", name: "newyork", state: "New York", country: "US", abbrev: "")
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    ErrorLog.destroy_all
    Sidekiq::Worker.clear_all
    if example.metadata[:sidekiq] == :fake
      Sidekiq::Testing.fake!
    elsif example.metadata[:sidekiq] == :inline
      Sidekiq::Testing.inline!
    else
      Sidekiq::Testing.fake!
    end
  end

  config.include Devise::TestHelpers, :type => :controller
end
