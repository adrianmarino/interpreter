require "bundler/setup"
require "ruml/path"
require "ruml/command"

desc "Transform ruby to uml graphic"
task :ruby2dot, [:input_file] => :build do |task, args|
  Command.execute("#{Path::RUBY_SRC}/ruby2do.rb #{args[:input_file]}")
end
