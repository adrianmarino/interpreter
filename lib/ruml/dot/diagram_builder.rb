require 'ruml/dot/class_box_builder'
require 'ruml/dot/module_box_builder'

module Ruml
  module Dot
    class DiagramBuilder
      def initialize
        @members = []
      end

      def module_box(name)
        add_member(Dot::ModuleBoxBuilder.new(name))
      end

      def class_box(name)
        add_member(Dot::ClassBoxBuilder.new(name))
      end

      def build
        diagram(build_body)
      end

      private

      def add_member(member)
        @members << member
        member
      end

      def build_body
        @members.map { |member| member.build(@members) }.join
      end

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
end
