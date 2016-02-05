require 'active_support/inflector'

module Ruml
  module Dot
    class ModuleBoxBuilder

      attr_reader :name

      def initialize(name)
        @members = Hash.new { |hash, key| hash[key] = [] }
        @name = name
      end

      def include(module_name)
        module_name = module_name == 'self' ? @name : module_name
        @members[:includes] << module_name
        self
      end

      def extend(module_name)
        module_name = module_name == 'self' ? @name : module_name
        @members[:extends] << module_name
        self
      end

      def attribute(attribute)
        @members[:attributes] << attribute.gsub(':', '')
        self
      end

      def method(method_name, params, type = :instance)
        @members[:methods] << [method_name, params, type]
        self
      end

      def build(objects = [])
        build_box
        build_associations(objects)
        @content
      end

      protected

      def build_associations(objects)
        append_inclusion(:includes, :dotted, 'Include')
        append_inclusion(:extends, :dotted, 'Extend')
        add_compositions(objects)
      end

      private

      def add_compositions(objects)
        associations = objects.map { |obj| obj.name.downcase } & @members[:attributes].map(&:singularize)
        associations.each do |association|
          append_association_with(association.capitalize, :filled, 'Has', :in, :odiamond)
        end
      end

      def append_association_with(member, style, label = '', direction = :out, arrowtail = '' )
        options = ["style=#{style}"]
        options << ["label=#{label}", "fontcolor=darkblue"] unless label.empty?
        options << "arrowtail=#{arrowtail}" unless arrowtail.empty?

        if direction == :out
          origin = member
          destiny = name
        else
          origin = name
          destiny = member
        end

        @content += "\s\s\"#{origin}\"->\"#{destiny}\"[#{options.join(', ')}]\n"
      end

      def build_box
        begin_box
        append(:attributes)
        append(:methods) do |(name, params, type)|
          "#{type == :class ? "." : "#"}#{name}(#{params.join(', ')})"
        end
        end_box
      end

      def begin_box
        @content = "\s\s\"#{@name}\"[label = \"{\[#{@name}\]"
      end

      def end_box
        @content += "}\"]\n"
      end

      def append(member_name)
        separator(member_name)
        @content = @members[member_name].inject(@content) do |content, member|
          content + "#{block_given? ? yield(member) : member}\\l"
        end
      end

      def separator(member_name)
        @content += "|" if @members[member_name].any?
      end

      def append_inclusion(member_name, style, label = '')
        @members[member_name].each { |member| append_association_with(member, style,  label) }
      end
    end
  end
end
