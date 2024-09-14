# Up and running 🏃‍➡️

Before we get too far, let’s get Phlex up and running in your app.

Phlex is a standalone Ruby library with zero dependencies, but most folks will want to use it with [Ruby on Rails](https://rubyonrails.org) so let’s start there for the sake of this guide.

It’s possible to use Phlex with [Sinatra](https://sinatrarb.com), [Roda](https://github.com/jeremyevans/roda), [Hanami](https://hanamirb.org), and any other Ruby web framework, but you’ll need to kick off the rendering yourself.

## Installing Phlex in a Rails app

To install Phlex in a Rails app, you’ll need to add the `phlex-rails` gem to your `Gemfile`. The `phlex-rails` gem includes the `phlex` gem as a dependency, so you won’t need to add that separately. `phlex-rails` also includes a generator to help you get started.

Start by running:

```
bundle add phlex-rails --version=2.0.0.beta2
```

This will install the latest version of `phlex` and `phlex-rails` and add `phlex-rails` to your `Gemfile`. Once that’s finished, you’ll want to run the install generator to kick things off:

```
bundle add phlex --version=2.0.0.beta1
```
