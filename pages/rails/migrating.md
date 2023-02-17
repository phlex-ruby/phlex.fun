---
title: Migrating to Phlex in Rails
---

# Migrating an existing Rails app to Phlex

Whether you currently use ActionView or ViewComponent with ERB, HAML or Slim, you can start using Phlex in your Rails app today without a big rewrite.

## You can render Phlex views into existing templates

Phlex views implement the _renderable_ interface for Rails, which means they can be rendered from a controller or another view template — even ViewComponent templates. This means you can gradually migrate specific views and components to Phlex without having to change everything at once.

If you're migrating from ViewComponent, you might find you can convert components to Phlex views without even changing any call-sites.

## You can render ActionView partials and ViewComponent components in Phlex views

The `render` method in Phlex doesn't only work with Phlex views. You can use it to render ActionView partials and ViewComponent components.

## Use an ERB → Phlex converter

The ERB → Phlex converter, [Phlexing](https://www.phlexing.fun), can do the heavy-lifting but it won't help you architect your components / design system.