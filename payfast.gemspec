# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/payfast/version'

Gem::Specification.new do |s|
  s.name = 'payfast'
  s.version = Payfast::VERSION
  s.author = 'Dellan Muchengapadare'
  s.email = 'mactunechy@gmail.com'
  s.homepage = 'https://github.com/mactunechy/payfast'
  s.summary = 'A light weight gem to setup payfast payment gateway'
  s.description = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.licenses = ['MIT']

  spec.required_ruby_version = '>= 2.7.0'

  s.files = Dir['{bin,lib,spec}/**/*'] + ['LICENSE', 'README.md']
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake', '~> 11.2.2'

  s.add_development_dependency 'rails', '~> 7.0.7'
end
