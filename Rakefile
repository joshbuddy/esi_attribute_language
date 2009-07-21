begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "esi_attribute_language"
    s.description = s.summary = "ESI Attribute Language"
    s.email = "joshbuddy@gmail.com"
    s.homepage = "http://github.com/joshbuddy/esi_attribute_language"
    s.authors = ["Joshua Hull"]
    s.files = FileList["[A-Z]*", "{lib,spec}/**/*"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "Build it up"
task :build do
  sh "rex --independent -o lib/esi_attribute_language/grammar/grammar.rex.rb lib/esi_attribute_language/grammar/grammar.rex"
  sh "racc -v -O parser.output -o lib/esi_attribute_language/grammar/grammar.y.rb lib/esi_attribute_language/grammar/grammar.y"
  sh "rex --independent -o lib/esi_attribute_language/grammar/simple.rex.rb lib/esi_attribute_language/grammar/simple.rex"
  sh "racc -v -O parser.output -o lib/esi_attribute_language/grammar/simple.y.rb lib/esi_attribute_language/grammar/simple.y"
end

require 'spec'
require 'spec/rake/spectask'

task :spec => 'spec:all'
namespace(:spec) do
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_opts ||= []
    t.spec_opts << "-rubygems"
    t.spec_opts << "--options" << "spec/spec.opts"
    t.spec_files = FileList['spec/**/*.rb']
  end

end
