# Ruml

Ruby2dot

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruml

## Use

Step1:
```bash
rake parser:build; bin/ruby2dot.rb spec/fixtures/test.rb | xdot
```
