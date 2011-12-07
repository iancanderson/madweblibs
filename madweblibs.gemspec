# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "madweblibs/version"

Gem::Specification.new do |s|
  s.name        = "madweblibs"
  s.version     = Madweblibs::VERSION
  s.authors     = ["Ian Anderson"]
  s.email       = ["anderson.ian.c@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generates 1 million dollar ideas for web libraries.}
  s.description = %q{Because the world needs more buzzwords.}

  s.rubyforge_project = "madweblibs"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "linguistics", "~> 1.0.9"
end
