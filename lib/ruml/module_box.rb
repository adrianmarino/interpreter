module Ruml
  class ModuleBox
    def initialize(name)
      @members = Hash.new { |hash, key| hash[key] = [] }
      @name = name
    end

    def include(name)
      name = name == 'self' ? @name : name
      @members[:includes] << name
      self
    end

    def extend(name)
      name = name == 'self' ? @name : name
      @members[:extends] << name
      self
    end

    def attribute(name)
      @members[:attributes] << name
      self
    end

    def method(name, params, type = :instance)
      @members[:methods] << [name, params, type]
      self
    end

    def build
      build_box
      build_association
      @content
    end

    protected

    def build_association
      append_inclusion(:includes, :dotted, 'include')
      append_inclusion(:extends, :dotted, 'extend')
    end

    def append_association_with(member, style, label = '', direction = :out)
      options = ", label=#{label}, fontcolor=darkblue" unless label.empty?

      if direction == :out
        origin = member
        destiny = @name
      else
        origin = @name
        destiny = member
      end

      @content += "\s\s\"#{origin}\"->\"#{destiny}\"[style=#{style}#{options}]\n"
    end

    private

    def build_box
      begin_box
      append(:attributes)
      append(:methods) do |(name, params, type)|
        "#{type == :class ? "." : "#"}#{name}(#{params.join(', ')})"
      end
      end_box
    end

    def begin_box
      @content = "\s\s\"#{@name}\"[label = \"{\[#{@name}\]"
    end

    def end_box
      @content += "}\"]\n"
    end

    def append(member_name)
      separator(member_name)
      @content = @members[member_name].inject(@content) do |content, member|
        content + "#{block_given? ? yield(member) : member}\\n"
      end
    end

    def separator(member_name)
      @content += "|" if @members[member_name].any?
    end

    def append_inclusion(member_name, style, label = '')
      @members[member_name].each { |member| append_association_with(member, style,  label) }
    end
  end
end
