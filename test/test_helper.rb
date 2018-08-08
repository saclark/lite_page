require 'simplecov'
require 'coveralls'
require 'minitest/autorun'
require 'minitest/spec'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start { add_filter '/test/' }
Coveralls.wear!

require 'lite_page'
