require 'rake'

BUILD_PATH="build"
CLASS_PATH = "-cp .:/usr/share/java/antlr-complete.jar"
JAVA = "java #{CLASS_PATH}"

task :clean do
  puts "clean"
  `rm -rf #{BUILD_PATH}`
end

task :build, [:grammar] => :clean do |task, args|
  grammar = args[:grammar]
  puts "build"
  `mkdir #{BUILD_PATH}`
  `antlr4 -no-listener -visitor #{grammar}.g4 -o #{BUILD_PATH}`
  `javac #{BUILD_PATH}/*.java`
end

task :tree, [:grammar, :input_file] => :build do |task, args|
  grammar = args[:grammar]
  args.with_defaults(:start_rule => 'program')
  input_file = args[:input_file]
  start_rule = args[:start_rule]

  puts "Parse #{input_file} with #{grammar} grammar"
  `cd #{BUILD_PATH}; #{JAVA} org.antlr.v4.runtime.misc.TestRig #{grammar} #{start_rule} -gui ../#{input_file}`
end
