import 'RumlBaseVisitor'
import 'RumlLexer'
require 'ruml/class_box'

module Ruml
  class VisitorImpl < RumlBaseVisitor

    def visitRuml(ctx)
      diagram(visit(ctx.class_def(0)))
    end

    def visitClass_def(ctx)
      builder = ClassBox.new(visit(ctx.class_name))
      builder.super_class(visit(ctx.super_class_name)) if ctx.super_class_name
      builder.build
    end

    def visitClass_name(ctx)
      ctx.IDENTIFIER.getText
    end

    def visitSuper_class_name(ctx)
      ctx.IDENTIFIER.getText
    end

    # def visitBody(ctx)
    # end

    # def visitModule_def(ctx)
    # end
    # def visitModule_name(ctx)
    # end
    # def visitClass_def(ctx)
    # end

    # def visitInclude_def(ctx)
    # end
    # def visitExtend_def(ctx)
    # end
    # def visitAttributes_def(ctx)
    # end
    # def visitClass_method_def(ctx)
    # end
    # def visitClass_method_name(ctx)
    # end
    # def visitInstance_method_def(ctx)
    # end
    # def visitInstance_method_name(ctx)
    # end
    # def visitParams(ctx)
    # end
    # def visitParam(ctx)
    # end
    # def visitParam_value(ctx)
    # end
    # def visitKeyword_param(ctx)
    # end
    # def visitKeyword_param_name(ctx)
    # end
    # def visitDefault_param(ctx)
    # end
    # def visitDefault_param_name(ctx)
    # end
    # def visitValue(ctx)
    # end

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
  end
end
