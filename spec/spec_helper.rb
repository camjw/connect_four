require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

ENV['TEST_ENV'] = 'test'

# RSpec.configure do |config|
#   original_stderr = $stderr
#   original_stdout = $stdout
#   config.before(:all) do
#     # Redirect stderr and stdout
#     $stderr = File.new(File.join(File.dirname(__FILE__), 'log.txt'), 'w')
#     $stdout = File.new(File.join(File.dirname(__FILE__), 'log.txt'), 'w')
#   end
#   config.after(:all) do
#     $stderr = original_stderr
#     $stdout = original_stdout
#   end
# end
#
# require 'rake'
# require 'simplecov'
# require 'simplecov-console'
# require 'pry'
#
#
# SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
#   SimpleCov::Formatter::Console,
#   SimpleCov::Formatter::HTMLFormatter
# ])
# SimpleCov.start
