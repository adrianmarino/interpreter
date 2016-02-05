require 'ruml/module_box'

module Ruml
  class ClassBox < ModuleBox
    def super_class(name)
      @super_name = name
      self
    end

    def build_association
      append_association_with(@super_name, :filled) if @super_name
      super
    end
  end
end
