---
title: Getting started with Rails
---

# Getting started with Phlex on Rails

While Phlex can be used in any Ruby project, it’s especially great with [Rails](https://rubyonrails.org). But before we get into the details, it’s important to understand that Phlex is very different from [ActionView](https://guides.rubyonrails.org/action_view_overview.html) and [ViewComponent](https://viewcomponent.org).

## Setup

To use Phlex with Rails, you’ll need to install the [`phlex-rails`](https://rubygems.org/gems/phlex-rails) gem. Add the following to your Gemfile and run `bundle install`.

```ruby
gem "phlex-rails"
```

Note, you do not need to install `phlex` separately because `phlex` is a dependency of `phlex-rails`.

Once the gem is installed, run the install generator.

```bash
bin/rails generate phlex:install
```

This script will:

1. update `config/application.rb` to include `app/views`, `app/views/components`, and `app/views/layouts` in your auto-load paths;
2. generate `views/application_view.rb`
3. generate `views/layouts/application_layout.rb`
4. generate `views/components/application_component.rb`

`ApplicationComponent` is your base component which all your other components inherit from. By default, `ApplicationView` inherits from `ApplicationComponent`.
