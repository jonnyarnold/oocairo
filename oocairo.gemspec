base_dir = File.dirname(__FILE__)
Gem::Specification.new do |s|
  s.name = "oocairo"
  s.version = "0.0.1"
  s.authors = ["Jonny Arnold"]
  s.email = ["jonny.arnold89@gmail.com"]
  s.summary = "Object oriented API for Cairo"
  s.description = "Object oriented API for Cairo"
  s.homepage = "http://github.com/jonnyarnold/ruby-sandbox"
  s.licenses = ["Ruby's"]
  s.require_paths = ["lib"]

  s.files = ["Gemfile", "rakefile"]
  s.files += Dir.glob("{lib,samples}/**/*.rb")
  s.test_files = Dir.glob("test/**/*.rb")

  s.add_runtime_dependency("pkg-config")
  s.add_runtime_dependency("cairo")
  s.add_development_dependency("rake")
  s.add_development_dependency("bundler")
  s.add_development_dependency("mocha")
end