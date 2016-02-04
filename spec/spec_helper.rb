require 'bundler/setup'
Bundler.setup(:default, :test)
require "ruml/path"
Path.classes.each { |path| $CLASSPATH << path }
require 'ruml'
require 'pry'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
