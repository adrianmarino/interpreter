# Ruml

Ruby to dot transpiler.

###  Requisites

* JRuby
```bash
rvm install jruby
rvm use jruby
```

* Antlr4 (On Arch linux)
```bash
yaourt -S antlr4
alias grun='java -cp .:/usr/share/java/antlr-complete.jar org.antlr.v4.runtime.misc.TestRig "$@"'
```

### Install

```bash
rake install:local
```

### Use

#### Generate dot diagram from irb

```ruby
require 'ruml'; Ruml::Transpiler::Ruby2Dot.from_path('example/input.rb').compile
```

#### Generate dot diagram with ruby2dot command

Generate dot output and visualize in xdot viewer:
```bash
bin/ruby2dot example/input.rb | xdot
```

![alt Models Diagram](https://raw.githubusercontent.com/adrianmarino/ruml/master/example/output.png)
