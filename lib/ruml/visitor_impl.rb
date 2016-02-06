import 'RumlBaseVisitor'
import 'RumlLexer'
require 'ruml/dot/diagram_builder'

module Ruml
  class VisitorImpl < RumlBaseVisitor

    def visitRuml(ctx)
      @diagram_builder = Dot::DiagramBuilder.new
      visitChildren(ctx)
      @diagram_builder.build
    end

    def visitModule_def(ctx)
      @member_builder = @diagram_builder.module_box(ctx.IDENTIFIER.getText)
      visit(ctx.body)
    end

    def visitClass_def(ctx)
      @member_builder = @diagram_builder.class_box(visit(ctx.class_name))
      @member_builder.super_class(visit(ctx.super_class_name)) if ctx.super_class_name
      visit(ctx.body)
    end

    def visitAttr_reader(ctx)
      ctx.SYMBOL.each { |node| @member_builder.attribute(node.getText, :r) }
    end

    def visitAttr_writter(ctx)
      ctx.SYMBOL.each { |node| @member_builder.attribute(node.getText, :w) }
    end

    def visitAttr_accessor(ctx)
      ctx.SYMBOL.each { |node| @member_builder.attribute(node.getText, :rw) }
    end

    def visitInclude_def(ctx)
      @member_builder.include(ctx.IDENTIFIER.getText)
    end

    def visitExtend_def(ctx)
      @member_builder.extend(ctx.IDENTIFIER.getText)
    end

    def visitClass_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitSuper_class_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitClass_method_def(ctx)
      @member_builder.method(visit(ctx.class_method_name), visit(ctx.params), :class)
    end

    def visitClass_method_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitInstance_method_def(ctx)
      @member_builder.method(visit(ctx.instance_method_name), visit(ctx.params))
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
  end
end
