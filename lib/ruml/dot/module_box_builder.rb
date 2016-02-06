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

      def attribute(attribute, type)
        @members[:attributes] << [attribute.gsub(':', ''), type]
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
        names = objects.map { |obj| obj.name.downcase }

        associations = @members[:attributes].map do |(attr, _type)|
          [attr.singularize.capitalize, attr.singular? ? :one : :many] if names.include?(attr.singularize)
        end.compact

        associations.each do |name, type|
          append_association_with(name.capitalize, :filled, "\"Has #{type}\"", :in, :odiamond)
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
        append_attributes
        append_methods
        end_box
      end

      def begin_box
        @content = "\s\s\"#{@name}\"[label = \"{#{@name} (Mod)"
      end

      def end_box
        @content += "}\"]\n"
      end

      def append_attributes
        separator(:attributes)
        @content = @members[:attributes].inject(@content) do |content, (member, type)|
          content + "(#{type.to_s}) #{member}\\l"
        end
      end

      def append_methods
        separator(:methods)
        @content = @members[:methods].inject(@content) do |content, (name, params, type)|
         signature = type == :class ? '.' : '#'
         signature += name
         signature += "(#{params.join(', ')})" if params.any?
         content + "#{signature}\\l"
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
