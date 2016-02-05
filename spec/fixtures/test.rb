class Integer < Number
  include Enumerable
  extend self

  attr_reader :a, :b, :c
  attr_writer :x
  attr_accessor :c

  def Integer.class_method_a(a: "a", b: :b, c:, d = "d")
  end

  def self.class_method_b(a)
  end

  def instance_method(a, b)
  end
end

class Number
  attr_accessor :c
end

module Enumerable
  attr_accessor :c
end
