require 'coveralls'
Coveralls.wear!

require 'rake'
require 'simplecov'
require 'simplecov-console'
require 'pry'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
