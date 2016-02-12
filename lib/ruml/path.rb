ANTLR_JAR     = "antlr.jar"

module Path
  extend self

  RUBY_SRC      = "lib/ruml"
  GRAMMAR       = "#{RUBY_SRC}/grammar"
  GRAMMAR_SRC   = "#{GRAMMAR}/src"
  GRAMMAR_BUILD = "#{GRAMMAR}/build"
  ANTLR         = "#{GRAMMAR}/#{ANTLR_JAR}"

  def class_path
    ["ruml/grammar/build", "ruml/grammar/#{ANTLR_JAR}"]
  end
end
