module Path
  extend self

  GRAMMAR       = "lib/ruml/grammar"
  GRAMMAR_SRC   = "#{GRAMMAR}/src"
  GRAMMAR_BUILD = "#{GRAMMAR}/build"
  RUBY_SRC      = "lib/ruml"

  def class_path
    ["ruml/grammar/build", "ruml/grammar/antlr.jar"]
  end
end
