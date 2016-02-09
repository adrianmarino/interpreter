#!/usr/bin/env ruby
require "bundler/setup"
require "ruml/path"
Path.classes.each { |path| $CLASSPATH << path }
require "ruml"
require 'pry'

input_path = ARGV[0]

transpiler = Ruml::Ruby2DotTranspiler.from_path(input_path)

options = Ruml::Dot::Options.default

diagram = transpiler.compile(options)

puts diagram
