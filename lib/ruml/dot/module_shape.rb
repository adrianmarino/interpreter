require 'active_support/inflector'
require 'ruml/dot/association'
require 'ruml/dot/shape'

module Ruml::Dot
  class ModuleShape
    include Shape

    attr_reader :name

    def initialize(name, options)
      @members      = Hash.new { |hash, key| hash[key] = [] }
      @name         = name
      @indentation  = options[:indentation]
      @options      = options[type_from]
    end

    def module(action, module_name)
      module_name = module_name == 'self' ? @name : module_name
      @members[action] << module_name
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

    def append_assoc(assoc)
      @content += "#{@indentation}#{assoc}\n"
    end

    def build_associations(objects)
      append_inclusions(:include)
      append_inclusions(:extend)
      append_compositions(objects)
    end

    private

    def append_compositions(objects)
      objects.each do |object|
        associations = @members[:attributes].map do |attr, _type|
          [ attr.singular? ? :one : :many, object.name ] if attr.singularize == object.name.downcase
        end.compact
        associations.each do |type, object_name|
          append_assoc(Association.composition(@name, type, object_name))
        end
      end
    end

    def build_box
      begin_box
      append_attributes
      append_methods
      end_box
    end

    def begin_box
      @content = "#{@indentation}\"#{@name}\"[label=\"{#{@name} (Mod)"
    end

    def end_box
      @content += "}\" #{to_options(@options)}]\n"
    end

    def append_attributes
      append_separator(:attributes)
      @content = @members[:attributes].inject(@content) do |content, (member, type)|
        content + "(#{type.to_s}) #{member}\\l"
      end
    end

    def append_methods
      append_separator(:methods)
      @content = @members[:methods].inject(@content) do |content, (name, params, type)|
       signature = type == :class ? '.' : '#'
       signature += name
       signature += "(#{params.join(', ')})" if params.any?
       content + "#{signature}\\l"
     end
    end

    def append_separator(member)
      @content += "|" if @members[member].any?
    end

    def append_inclusions(member)
      @members[member].each { |module_name| append_assoc(Association.inclusion(member, @name, module_name)) }
    end
  end
end
