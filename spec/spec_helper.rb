require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

ENV['TEST_ENV'] = 'test'

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
