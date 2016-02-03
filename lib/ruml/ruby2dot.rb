import 'org.antlr.v4.runtime.ANTLRInputStream'
import 'org.antlr.v4.runtime.CommonTokenStream'
import 'java.io.FileInputStream'
import 'RumlLexer'
import 'RumlParser'
require 'ruml/visitor_impl'

module Ruml
  extend self

  def ruby_to_dot(ruby_file_path)
    input_stream  = FileInputStream.new(ruby_file_path);
    input         = ANTLRInputStream.new(input_stream)
    lexer         = RumlLexer.new(input)
    token_stream  = CommonTokenStream.new(lexer)
    parser        = RumlParser.new(token_stream)
    visitor       = RumlVisitorImpl.new
    visitor.visit(parser.calculator)
    visitor.results
  end
end
