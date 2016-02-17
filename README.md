[![Build Status](https://travis-ci.org/adrianmarino/ruml.svg?branch=master)](https://travis-ci.org/adrianmarino/ruml)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://badges.mit-license.org)


# Ruml

Ruby to dot transpiler.

###  Requisites

* Java 7: i.e. install using jenv:
```bash
$ curl -L -s get.jenv.io | bash
jenv install java 1.7.0_75
```

* JRuby: i.e. install using rvm
```bash
rvm install jruby
rvm use jruby
```

### Install

Download repo and install gem:

```bash
git clone https://github.com/adrianmarino/ruml.git
cd ruml
rake install:local
```
Or include in your Gemfile:

```ruby
gem 'ruml', git: 'https://github.com/adrianmarino/ruml.git', branch: 'master'
```

### Use

#### Generate dot diagram from irb

```ruby
require 'ruml'; Ruml::Transpiler::Ruby2Dot.from_path('example/input.rb').compile
```

#### Generate dot diagram with ruby2dot command

Next command read an [input ruby file](example/input.rb) and generate an output in dot language. Then redirect the output to xdot command.
xdot is a dot viewer.
```bash
bin/ruby2dot example/input.rb | xdot
```
xdot output:

![alt Models Diagram](https://raw.githubusercontent.com/adrianmarino/ruml/master/example/output.png)
