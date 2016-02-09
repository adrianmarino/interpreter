module Ruml::Dot
  class Association
    class << self
      def inheritance(class_name, super_class_name)
        new.origin(class_name).destiny(super_class_name).label('Is').style(:filled).build
      end

      def inclusion(type, class_name, module_name)
        label = type.to_s.singularize.capitalize
        new.origin(class_name).destiny(module_name).style(:dotted).label(label).build
      end

      def composition(class_name, type, children_name)
        new.origin(class_name).destiny(children_name).style(:filled).label("\"Has #{type}\"").
          arrowtail(:odiamond).build
      end
    end


    ATTRS = { required: %w[origin destiny], optionals: %w[style label arrowtail] }

    ATTRS.values.flatten.each { |attr| define_method(attr) { |value| set(attr, value); self } }

    def build
      check_required_attrs
      "\"#{@origin}\"->\"#{@destiny}\"[#{options}]"
    end

    private

    def options
      ATTRS[:optionals].map { |attr| "#{attr}=#{value_of(attr)}" if value_of(attr) }.compact.join(', ')
    end

    def check_required_attrs
      ATTRS[:required].each { |attr| raise "Assocation #{attr} not defined!" unless value_of(attr) }
    end

    def value_of(attr)
      instance_variable_get("@#{attr}")
    end

    def set(attr, value)
      instance_variable_set("@#{attr}", value)
    end
  end
end
