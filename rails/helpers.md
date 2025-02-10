# Working with Rails view helpers in Phlex

There are primarily two kinds of Rails view helpers. _Output_ helpers return HTML to be rendered raw while _value_ helpers return a value to be used in a conditional or output in an HTML attribute.

There are also helpers that don’t return anything, but we treat them as value helpers with no return value. The key distinction is whether or not the helper is expected to output its return value.

Here’s an example that combines the two: `link_to` is an _output_ helper while `article_path` is a _value_ helper.

```ruby
link_to "Article", article_path(@article)
```

`link_to` should take the return value from the helper and push it to the buffer immediately. If it didn’t do this, you would have to prefix it with `raw`. Conversely, `article_path` shouldn’t push anything. Instead, it should return the value.

To handle these differences, `phlex-rails` uses adapters, which know what kind of helper they’re adapting.

## Built-in adapters

`phlex-rails` comes with adapters for all of Rails’ built-in view helpers. If we’re missing one, please [open an issue](https://github.com/phlex-ruby/phlex-rails/issues/new). None of the adapters are included by default because you probably don’t need that many helpers if you’re using Phlex. For example, do you really need `link_to` when you have `a`?

The one you probably _will_ need is the routing adapter, which makes all the routing helpers available. It’s a good idea to include this in your base component so it’s available everywhere.

```ruby
class Components::Base < Phlex::HTML
  include Phlex::Rails::Helpers::Routing
end
```

All the other adapters are available as modules under the `Phlex::Rails::Helpers` namespace. The module name will match the name of the Rails helper method.

::: tip
If you try to use a Rails helper that you haven’t included, you’ll get a `NoMethodError`. If you read the message carefully, it should tell you exactly which adapter module you need to include.
:::

## Registering custom helper adapters

Sometimes you need to register an adapter for your own view helpers, or those provided by Ruby Gems. To do this, you can use the class methods `register_value_helper` and `register_output_helper`.

```ruby
class Components::Base < Phlex::HTML
  register_output_helper :pagy_nav
end
```

::: warning
You should never include Rails view helper modules directly. They are not designed to work with Phlex and they may override core Phlex methods such as `capture`, which will lead to all kinds of problems.
:::

## An alternative to custom helpers

There’s a good chance anything you’d have put in a custom view helper would be better as a component in Phlex.

Alternatively, you can define your own Phlex helpers as plain old methods — either directly on your base component or in a module that you include in the relevant components. In this context, your helpers can use regular HTML element methods rather than messing around with `safe_concat`.
