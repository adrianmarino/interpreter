require 'ruml/dot/shape/module'
require 'ruml/dot/association'

module Ruml::Dot::Shape
  class Class < Module
    def super_class(value)
      @super_name = value
      self
    end

    def build_associations(objects)
      append_assoc(Ruml::Dot::Association.inheritance(@name, @super_name)) if @super_name
      super(objects)
    end
  end
end
