module Ruml::Dot::Shape
  include Ruml::Dot::Helper

  class << self
    def class_from(type)
      "Ruml::Dot::#{type.to_s.capitalize}Shape".constantize
    end
  end

  def type_from
    class_name = self.class.name.split('::').last
    option_group = class_name.gsub('Shape','').downcase
    option_group.to_sym
  end
end
