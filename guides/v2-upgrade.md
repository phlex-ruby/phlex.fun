# Upgrading to v2

While we’ve tried to keep breaking changes to a minimum, there are a few things you will need to be aware of when upgrading from Phlex v1 to v2.

The latest version of v1 contains a number of deprecations, so we recommend upgrading to the latest version of v1 first.

## Breaking changes

### Renamed `template` → `view_template`

Instead of defining the `template` method for your component templates, you should instead define `view_template`.

### Renamed `template_tag` → `template`

To render [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template) elements in a `Phlex::HTML` component, you need to call the `template` method instead of the original `template_tag` method.

### Removed `tokens` and `classes`

There are [better ways to handle conditional tokens now](../handbook/attributes.md#attribute-values), so we removed these helpers. If you need them back to support your existing code, you can copy their original implementation from below.

::: details Original `classes` and `tokens` implementation

```ruby
def classes(*tokens, **conditional_tokens)
  tokens = self.tokens(*tokens, **conditional_tokens)

  if tokens.empty?
    {}
  else
    { class: tokens }
  end
end

def tokens(*tokens, **conditional_tokens)
  conditional_tokens.each do |condition, token|
    truthy = case condition
      when Symbol then send(condition)
      when Proc then condition.call
      else raise ArgumentError, "The class condition must be a Symbol or a Proc."
    end

    if truthy
      case token
        when Hash then __append_token__(tokens, token[:then])
        else __append_token__(tokens, token)
      end
    else
      case token
        when Hash then __append_token__(tokens, token[:else])
      end
    end
  end

  tokens = tokens.select(&:itself).join(" ")
  tokens.strip!
  tokens.gsub!(/\s+/, " ")
  tokens
end

private

def append_token(tokens, token)
  case token
    when nil then nil
    when String then tokens << token
    when Symbol then tokens << token.name
    when Array then tokens.concat(token)
    else raise ArgumentError,
      "Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
  end
end
```

:::

### `unsafe_raw` → `raw`

We've renamed `unsafe_raw` to `raw`, and we've made it so that it will only output content if it's marked as safe. You can use the new `safe` helper to mark content as safe. Additionally, if you're using Rails, `ActiveSupport::SafeBuffer` is also treated as safe, so any methods that return an `ActiveSupport::SafeBuffer` (like `String#html_safe`) can also be output by `raw`.

With the addition of `safe`, we've also made it so that element blocks that return safe content will be output with `raw` instead of `plain`. This means if the only content inside an element was an `unsafe_raw` call, you can now just call `safe`.

#### Before

```ruby
def markdown(content)
  rendered_markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content)
  unsafe_raw(rendered_markdown)
end
```

```ruby
script do
  unsafe_raw "alert('Hello!')"
end
```

#### After

```ruby
def markdown(content)
  rendered_markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content)
  raw(safe(rendered_markdown))
end
```

```ruby
script do
  safe "alert('Hello!')"
end
```

### New opinionated Rails generators

We’ve made some significant changes to the Rails generators, which now assume a specific folder structure and naming convention for views and components.

The `install` generator now create an _initializer_ file in `config/initializers/phlex.rb` where the modules: `Views` and `Components` are defined. It also autoloads the `app/views` and `app/components` directories with the `Views` and `Components` namespaces respectively.

::: details `config/initializers/phlex.rb`

```ruby
# frozen_string_literal: true

module Views
end

module Components
  extend Phlex::Kit
end

Rails.autoloaders.main.push_dir(
  "#{Rails.root}/app/views", namespace: Views
)

Rails.autoloaders.main.push_dir(
  "#{Rails.root}/app/components", namespace: Components
)
```

:::

It also creates a `Base` class for both views and components.

The `view` generator now creates views under `app/views`, namespaced under `Views`.

::: details Example view

```ruby
# frozen_string_literal: true

class Views::Articles::Index < Views::Base
  def view_template
    h1 { "Articles" }
  end
end
```

:::

The `component` generator now creates components under `app/components`, namespaced under `Components`.

::: details Example component

```ruby
# frozen_string_literal: true

class Components::Button < Components::Base
  def view_template
    button { "Click me" }
  end
end
```

:::

## New features

### Kits

Originally previewed in v1, kits are now out of beta and fully supported in v2. Kits are a way to package up a set of components into a module.

### Selective rendering

### A better cache

Phlex v2 introduces a new attribute cache that caches more things. We wrote about some of the technical details [here](/design/caching).
