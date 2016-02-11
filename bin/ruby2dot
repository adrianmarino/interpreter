#!/usr/bin/env ruby
require "bundler/setup"
require "ruml"

input_path = ARGV[0]

transpiler = Ruml::Transpiler::Ruby2Dot.from_path(input_path)

options = Ruml::Dot::Options.default

diagram = transpiler.compile(options)

puts diagram
