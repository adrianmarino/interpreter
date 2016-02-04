module Ruml
  class ClassBox
    def initialize(name)
      @attributes = []
      @methods = []
      @name = name
    end

    def super_class(name)
      @super_name = name
    end

    def attribute(name)
      @attributes < name
      self
    end

    def method(name, params)
      @methods < [name, params]
      self
    end

    def build
      @content = "\"#{@name}\"[label = \"{#{@name}"

      @content += "|" if @attributes.any? || @methods.any?

      @attributes.each_with_object(@content) do |attribute, content|
        content += "#{attribute}\n"
      end

      @content += "|" if @attributes.any?

      @methods.each_with_object(@content) do |(name, params), content|
        content += "#{name}(#{params})\n"
      end

      @content += "}\"]\n"
      @content += "\"#{@name}\"->\"#{@super_name}\"\n" if @super_name

      @content
    end
  end
end
