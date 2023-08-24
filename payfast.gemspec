# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "payfast"
  s.version = "1.0.5"
  s.author = "Dellan Muchengapadare"
  s.email = "mactunechy@gmail.com"
  s.homepage = "https://github.com/mactunechy/payfast-gem"
  s.summary = "A light weight gem to setup payfast payment gateway"
  s.description = File.read(File.join(File.dirname(__FILE__), "README.md"))
  s.licenses = ["MIT"]

  s.files = Dir["{bin,lib,spec}/**/*"] + ["LICENSE", "README.md"]
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake", "~> 11.2.2"

  s.add_development_dependency "rails", "~> 7.0.7"
end
