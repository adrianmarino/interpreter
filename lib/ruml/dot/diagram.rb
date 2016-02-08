require 'ruml/dot/class_box'
require 'ruml/dot/module_box'

module Ruml::Dot
  class Diagram
    def initialize
      @members = []
    end

    def box(member, name)
      member = box_class_of(member).new(name)
      @members << member
      member
    end

    def build
      body= @members.map { |member| member.build(@members) }.join
      diagram(body)
    end

    private

    def box_class_of(member)
      "Ruml::Dot::#{member.to_s.capitalize}Box".constantize
    end

    def diagram(content)
      <<-DOT
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
