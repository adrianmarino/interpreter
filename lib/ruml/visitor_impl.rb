import 'RumlBaseVisitor'
import 'RumlLexer'
require 'ruml/class_box'

module Ruml
  class VisitorImpl < RumlBaseVisitor

    def visitRuml(ctx)
      diagram(visit_and_join(ctx.module_def) + visit_and_join(ctx.class_def))
    end

    def visitModule_def(ctx)
      @builder = ModuleBox.new(ctx.IDENTIFIER)
      visit(ctx.body)
      @builder.build
    end

    def visitClass_def(ctx)
      @builder = ClassBox.new(visit(ctx.class_name))
      @builder.super_class(visit(ctx.super_class_name)) if ctx.super_class_name
      visit(ctx.body)
      @builder.build
    end

    def visitAttributes_def(ctx)
      ctx.SYMBOL.each { |node| @builder.attribute(node.getText) }
    end

    def visitInclude_def(ctx)
      @builder.include(ctx.IDENTIFIER.getText)
    end

    def visitExtend_def(ctx)
      @builder.extend(ctx.IDENTIFIER.getText)
    end

    def visitClass_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitSuper_class_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitInstance_method_def(ctx)
      @builder.method(visit(ctx.instance_method_name), visit(ctx.params))
    end

    def visitParams(ctx)
      ctx.param.map { |node| visit(node) }
    end

    def visitInstance_method_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitNormal_param(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitKeyword_param(ctx)
      "#{ctx.KEYWORD_PARAM_NAME.getText}#{ctx.value ? " #{visit(ctx.value)}" : ''}"
    end

    def visitDefault_param(ctx)
      "#{ctx.IDENTIFIER.getText} = #{visit(ctx.value)}"
    end

    def visitStringValue(ctx)
      ctx.STRING.getText
    end

    def visitSymbolValue(ctx)
      ctx.SYMBOL.getText
    end

    def visitNumberValue(ctx)
      ctx.NUMBER.getText
    end

    private

    def diagram(content)
      <<-DOT.strip_heredoc
digraph hierarchy {
  size="5,5"
  node[shape=record,style=filled,fillcolor=gray95]
  edge[dir=back, arrowtail=empty]
#{content}
}
DOT
    end

    def visit_and_join(nodes)
      nodes.map { |node| visit(node) }.join('')
    end
  end
end
