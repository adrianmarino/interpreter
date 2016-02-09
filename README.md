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

###  Test

Step 2: Build parser.
```bash
rake parser:build
```

Step 2: Test parser.
```bash
rake parser:tree[example/input.rb]
```

Step 3: Generate dot diagram and display with xdot app.
```bash
bin/ruby2dot.rb example/input.rb | xdot
```

![alt Models Diagram](https://github.com/adrianmarino/ruml/blob/feature/general-refactor/example/output.png)
