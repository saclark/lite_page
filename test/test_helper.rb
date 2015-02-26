require 'simplecov'
require 'coveralls'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start
Coveralls.wear!

require 'lite_page'
