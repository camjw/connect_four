# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

# require 'rake'
# require 'pry'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console,
                                                                 SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start

ENV['TEST_ENV'] = 'test'
