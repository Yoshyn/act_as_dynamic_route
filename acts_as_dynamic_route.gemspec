$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_dynamic_route/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_dynamic_route"
  s.version     = ActsAsDynamicRoute::VERSION
  s.authors     = ["Sylvestre Antoine"]
  s.email       = ["sylvestre.antoine[at]google.com"]
  s.homepage    = ""
  s.summary     = "ActsAsDynamicRoute."
  s.description = "ActsAsDynamicRoute."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.17"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
