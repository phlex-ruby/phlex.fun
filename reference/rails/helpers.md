# Rails Helpers

Phlex’ Rails extension includes an adapter for each Rails view helper. (Please open an issue if we’re missing one!)

Each adapter can be included from its own module under `Phlex::Rails::Helpers`. For example, the `link_to` helper can be included from `Phlex::Rails::Helpers::LinkTo`.

You’ll probably want to include the most common ones in an abstract super class, e.g. `Components::Base` or `Views::Base`.

## Why do we need adapters?

The way Phlex works is so fundamentally different from the way string-based templating langauges work, we need to adapt the helpers to make them feel natural.

Let’s think about `link_to` as an example. In ERB, you need to remember to use `link_to` like this:

```erb
<%= link_to "Click me", "/path" %>
```

The `=` sign is essential because it tells ERB to output the result of the expression. The equivalent in Phlex would be:

```ruby
unsafe_raw link_to("Click me", "/path")
```

That’s not very nice. If I’m using `link_to`, I obviously want to output the result. But there are _some_ helpers where this wouldn’t make sense. For example, we don’t want to immediately output the result `articles_path`.

To handle this, Phlex distinguishes between “output helpers” and “value helpers” so you can do something like this and it just works:

```ruby
link_to "Articles", articles_path
```

## Why are they separate modules?

The short answer is, we don’t think you’ll need to use many of the Rails helpers and it seems wasteful to load them all by default.

Take the above example. Is `link_to` really better than `a`?

```ruby
a "Articles", href: articles_path
```

::: tip
If you end up calling a Rails helper that you haven’t included the adapter for, you should get an error message explaining exactily which module to include.
:::

## Defining your own adapters

While the Rails extension defines adapters for all the standard Rails helpers, you can define your own adapters for custom helpers or third-party gems.

### `.register_output_helper`

You can use `register_output_helper` to define an adapter for a helper that returns HTML that should be output directly. All arguments will be passed through to the original helper.

```ruby
class Components::App < Components::Base
  register_output_helper :vite_javascript_tag
end
```

If you pass a block to an adapted output helper, the block will be wrapped in a `capture` so that it returns an `ActiveSupport::SafeBuffer`.

> [!IMPORTANT]
> The return value of the helper must be an `ActiveSupport::SafeBuffer`, which can be created by calling `html_safe` on a string. If the helper returns a different kind of value, nothing will be output.

### `.register_value_helper`

To adapt a helper that returns a value, use `register_value_helper`. This will return the result of the helper as a string. As before, any block passed to this helper will be wrapped in a `capture` so that it returns an `ActiveSupport::SafeBuffer`.

```ruby
class Components::Base < Phlex::HTML
  register_value_helper :vite_asset_path
end
```
