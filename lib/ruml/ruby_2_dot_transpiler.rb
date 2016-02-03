import 'org.antlr.v4.runtime.ANTLRInputStream'
import 'org.antlr.v4.runtime.CommonTokenStream'
import 'java.io.FileInputStream'
import 'RumlLexer'
import 'RumlParser'
require 'ruml/visitor_impl'

module Ruml
  class Ruby2DotTranspiler
    class << self
      def from_path(path)
        new(FileInputStream.new(path))
      end

      def from(value)
        new(ByteArrayInputStream.new(value.getBytes(StandardCharsets.UTF_8)))
      end
    end

    def initialize(input_stream)
      input         = ANTLRInputStream.new(input_stream)
      lexer         = RumlLexer.new(input)
      token_stream  = CommonTokenStream.new(lexer)
      @parser       = RumlParser.new(token_stream)
    end

    def compile
      visitor = VisitorImpl.new
      visitor.visit(@parser.ruml)
    end
  end
end
