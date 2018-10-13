require 'coveralls'
require 'rake'
require 'simplecov'
require 'simplecov-console'
require 'pry'

Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

Rake.application.load_rakefile
