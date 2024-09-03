# Setup

## Setting up Phlex with Rails

Let’s be honest, most of us are going to be using this with Rails so we’ll start there.

First, add `phlex-rails` to your Gemfile. The quickest way to do this is to run:

```
bundle add phlex-rails
```

This will add the latest version of `phlex` and `phlex-rails` and run `bundle install` for you. Now that the gem is installed, you’ll want to run the install geneartor:

```
bundle exec rails generate phlex:install
```

## Setting up Phlex without Rails

Phlex is actually a standalone library with zero dependencies. You can use it in any Ruby project, but you’ll need to kick off the rendering yourself.
