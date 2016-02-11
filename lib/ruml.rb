require "ruml/path"
Path.classes.each { |path| $CLASSPATH << path }

Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |file| require file }
