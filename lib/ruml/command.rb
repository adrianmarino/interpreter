require 'fileutils'
require "ruml/path"

module Command
  extend self

  GRAMMAR = "Ruml"

  def rm_rf(*paths)
    FileUtils.rm_rf(paths)
    self
  end

  def mkdir_p(*paths)
    FileUtils.mkdir_p(paths)
    self
  end

  def javac(input_path = Path::GRAMMAR_SRC, output_path = Path::GRAMMAR_BUILD)
    `javac #{input_path}/*.java -d #{output_path}`
    self
  end

  def generate_parser(output_path = Path::GRAMMAR_SRC)
    `cd #{Path::GRAMMAR}; antlr4 -no-listener -visitor #{GRAMMAR}.g4 -o ../../#{output_path}`
    self
  end

  def grun(input_file)
    `cd #{Path::GRAMMAR_BUILD}; grun #{GRAMMAR} #{GRAMMAR.downcase} -gui ../../../#{input_file}`
  end

  def pry
    execute(:pry)
  end

  def execute(command, class_path = Path.classes)
    exec "ruby -J-cp #{class_path.join(':')} -I #{Path::GRAMMAR_SRC} -S #{command.to_s}"
  end
end
