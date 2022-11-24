---
title: Getting started with Rails
---

# Getting started with Phlex on Rails

While Phlex can be used in any Ruby project, it’s especially great with [Rails](https://rubyonrails.org). But before we get into the details, it’s important to understand that Phlex is very different from [ActionView](https://guides.rubyonrails.org/action_view_overview.html) and [ViewComponent](https://viewcomponent.org).

In Phlex, _layouts_, _pages_ and _components_ (or “partials”) are the same thing. Phlex Views are Ruby objects that represent every piece of your app’s user interface, from pages and layouts and nav-bars, to headings and buttons and links. They’re not templates like ERB files in ActionView / ViewComponent; they are just Ruby objects.

It might feel a bit weird at first, but you’ll soon realise how weird it was writing procedural templates in ERB while every other part of your app was object-oriented Ruby.

## Setup

To use Phlex with Rails, you’ll need to install the [`phlex-rails`](https://rubygems.org/gems/phlex-rails) gem.

Add the following to your Gemfile and run `bundle install`.

```ruby
gem "phlex-rails"
```

Note, you do not need to install `phlex` separately becuase `phlex` is a dependency of `phlex-rails`.

Once the install is finished, you’ll want to run the setup script: `bin/rails phlex:install`.

This script will:

1. update `config/application.rb` to include `/app` in your auto-load paths;
2. generate `views/application_view.rb`.

Like `ApplicationRecord`, `ApplicationView` is your base view which all your other views should inherit from. It’s a bit different because it’s a module not a class, which means you can inherit from abstract views from other libraries and still mixin your own `ApplicationView` concerns.

## Naming conventions

We recommend using the Zeitwerk conventions for naming. For example, your Articles index page, would be called `Views::Articles::Index` and live in `app/views/articles/index.rb`.
