require 'ruml/dot/module_box'
require 'ruml/dot/association'

module Ruml::Dot
  class ClassBox < ModuleBox
    def super_class(value)
      @super_name = value
      self
    end

    def build_associations(objects)
      append_assoc(assoc.inheritance(@name,@super_name)) if @super_name
      super(objects)
    end

    def begin_box
      @content = "\s\s\"#{@name}\"[label = \"{#{@name}"
    end
  end
end
