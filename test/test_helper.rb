require 'simplecov'
require 'coveralls'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

SimpleCov.start { add_filter '/test/' }
Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require 'lite_page'
