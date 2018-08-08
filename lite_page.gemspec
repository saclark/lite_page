# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lite_page/version'

Gem::Specification.new do |spec|
  spec.name          = 'lite_page'
  spec.version       = LitePage::VERSION
  spec.authors       = ['Scott Clark']
  spec.email         = ['sclarkdev@gmail.com']
  spec.summary       = %q{A Page Object Model DSL for watir-webdriver}
  spec.description   = %q{A gem providing a quick, clean, and concise means of implementing the Page Object Model pattern and defining a semantic DSL for automated acceptance tests using watir-webdriver.}
  spec.homepage      = 'http://github.com/saclark/lite_page'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'watir', '6.0.0'

  spec.required_ruby_version = '>= 2.2.5'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 12.3.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'yard'
end
