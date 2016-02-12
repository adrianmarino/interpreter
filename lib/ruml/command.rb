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
    system("javac -cp #{Path::ANTLR} #{input_path}/*.java -d #{output_path}")
    self
  end

  def generate_parser(output_path = Path::GRAMMAR_SRC)
    command = "cd #{Path::GRAMMAR};"
    command += "java -jar #{ANTLR_JAR} "
    command += "-no-listener -visitor #{GRAMMAR}.g4 -o ../../../#{output_path}"
    system(command)
    self
  end

  def grun(input_file)
    command = "cd #{Path::GRAMMAR_BUILD};"
    command += "java -cp .:../#{ANTLR_JAR} org.antlr.v4.runtime.misc.TestRig "
    command += "#{GRAMMAR} #{GRAMMAR.downcase} -gui ../../../../#{input_file}"
    puts command
    `#{command}`
  end
end
