require 'ruml/module_box'

module Ruml
  class ClassBox < ModuleBox

    def super_class(name)
      @super_name = name
      self
    end

    def build_association
      append_association_with(@super_name, :filled, 'is') if @super_name
      super
    end

    def begin_box
      @content = "\s\s\"#{@name}\"[label = \"{#{@name}"
    end
  end
end
