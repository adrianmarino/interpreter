module Path
  extend self

  GRAMMAR       = "lib/grammar"
  GRAMMAR_SRC   = "#{GRAMMAR}/src"
  GRAMMAR_BUILD = "#{GRAMMAR}/build"
  RUBY_SRC      = "lib/ruml"

  def classes
    [GRAMMAR_BUILD, ANTLR_LIB]
  end

  private

  ANTLR_LIB = "/usr/share/java/antlr-complete.jar"

end
