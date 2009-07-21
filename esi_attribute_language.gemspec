# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{esi_attribute_language}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Hull"]
  s.date = %q{2009-07-21}
  s.description = %q{ESI Attribute Language}
  s.email = %q{joshbuddy@gmail.com}
  s.files = [
    "Rakefile",
     "VERSION",
     "lib/esi_attribute_language.rb",
     "lib/esi_attribute_language/grammar.rb",
     "lib/esi_attribute_language/grammar/grammar.rex",
     "lib/esi_attribute_language/grammar/grammar.rex.rb",
     "lib/esi_attribute_language/grammar/grammar.y",
     "lib/esi_attribute_language/grammar/grammar.y.rb",
     "lib/esi_attribute_language/grammar/lexer.rb",
     "lib/esi_attribute_language/grammar/parser.rb",
     "lib/esi_attribute_language/grammar/simple.rex",
     "lib/esi_attribute_language/grammar/simple.rex.rb",
     "lib/esi_attribute_language/grammar/simple.y",
     "lib/esi_attribute_language/grammar/simple.y.rb",
     "spec/attr_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/joshbuddy/esi_attribute_language}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{ESI Attribute Language}
  s.test_files = [
    "spec/attr_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
