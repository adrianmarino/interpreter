require 'ruml/dot/module_shape'
require 'ruml/dot/association'

module Ruml::Dot
  class ClassShape < ModuleShape
    def super_class(value)
      @super_name = value
      self
    end

    def build_associations(objects)
      append_assoc(Association.inheritance(@name, @super_name)) if @super_name
      super(objects)
    end

    def begin_box
      @content = "#{@indentation}\"#{@name}\"[label=\"{#{@name}"
    end
  end
end
