#!/usr/bin/env ruby
require "bundler/setup"
require "ruml/path"
Path.classes.each { |path| $CLASSPATH << path }
require "ruml"

require 'pry'

puts Ruml::Ruby2DotTranspiler.from_path(ARGV[0]).compile
