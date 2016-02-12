require "ruml/path"
Path.class_path.each { |path| $CLASSPATH << "#{File.dirname(__FILE__)}/#{path}" }

Dir[ "#{File.dirname(__FILE__)}/**/*.rb"].each { |file| require file unless file.end_with?("ruml.rb") }
