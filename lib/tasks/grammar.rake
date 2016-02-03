require "bundler/setup"
require "ruml/path"
require "ruml/command"

namespace :parser do
  desc "Remove parser *.class and *.java files"
  task :clean do
    puts "clean parser"
    Command.rm_rf(Path::GRAMMAR_BUILD, Path::GRAMMAR_SRC)
  end

  desc "Generate and compile parser and visitor"
  task :build => :clean do |task, args|
    Command.mkdir_p(Path::GRAMMAR_BUILD, Path::GRAMMAR_SRC, Path::RUBY_SRC)

    puts "generate parser"
    Command.generate_parser

    puts "build parser"
    Command.javac
  end

  desc "Show parse tree"
  task :tree, [:input_file] => :build do |task, args|
    puts "show AST"
    Command.grun(args[:input_file])
  end
end
