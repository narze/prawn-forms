# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "prawn-forms"
  s.version     = "0.1.0"
  s.authors     = ["James Healy"]
  s.homepage    = "https://github.com/yob/prawn-forms"
  s.summary     = %q{A prawn extension library for adding interactive forms}
  s.description = %q{Prawn-Forms depends on the core prawn library, and simply adds a few additional methods to the standard Prawn::Document object that allow you to add form elements to your output.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "prawn", "~> 0.11.1"
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
