# Setup

Let’s get Phlex up and running in your app.

Phlex is a standalone Ruby library with zero dependencies, but most folks will want to use it with [Ruby on Rails](https://rubyonrails.org) so let’s start there.

::: tip
It’s possible to use Phlex with [Sinatra](https://sinatrarb.com), [Roda](http://roda.jeremyevans.net), [Hanami](https://hanamirb.org) or any other Ruby framework, but you’ll need to kick off the rendering yourself.
:::

## Installing Phlex in a Rails app

To install Phlex in a Rails app, you’ll need to add the `phlex-rails` gem to your `Gemfile`. The `phlex-rails` gem includes the `phlex` gem as a dependency, so you won’t need to add that separately. `phlex-rails` also includes a generator to help you get started.

Start by running:

```
bundle add phlex-rails --version=2.0.0.rc1
```

This will install the latest version of `phlex` and `phlex-rails` and add `phlex-rails` to your `Gemfile`. Once that’s finished, you’ll want to run the install generator to kick things off:

```
bundle exec rails generate phlex:install
```

The install generator will configure Rails to autoload `app/views` as the `Views::` namespace and `app/components` as the `Components::` namespace. This may cause issues if you already have ViewComponent components under `app/components`.

There are a couple of ways you can fix this:

1. you could move your ViewComponent components under the `Components::` namespace by renaming them all. For example if you had a component called `CardComponent`, you would need to rename it to `Components::CardComponent`;
2. alternatively, you could move your ViewComponent components to a different directory such as `app/view_components` and autoload that directory in the root namespace.

It’s important for Phlex components to live in a module because of how Kits work, and we recommend the `Components` module under `app/components`.
