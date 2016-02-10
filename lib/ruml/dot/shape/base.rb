require 'ruml/extensions'

module Ruml::Dot::Shape
  class << self
    def class_from(type)
      "Ruml::Dot::Shape::#{type.to_s.capitalize}".constantize
    end
  end

  class Base
    include Ruml::Dot::Helper

    def type_from
      self.class.simple_name.downcase.to_sym
    end
  end
end
