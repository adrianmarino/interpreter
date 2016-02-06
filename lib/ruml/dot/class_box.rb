require 'ruml/dot/module_box'

module Ruml::Dot
  class ClassBox < ModuleBox
    def super_class(name)
      @super_name = name
      self
    end

    def build_associations(objects)
      append_association_with(@super_name, :filled, 'Is') if @super_name
      super(objects)
    end

    def begin_box
      @content = "\s\s\"#{@name}\"[label = \"{#{@name}"
    end
  end
end
