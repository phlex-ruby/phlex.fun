# Upgrading to v2

While we’ve tried to keep breaking changes to a minimum, there are a few things you will need to be aware of when upgrading from Phlex v1 to v2.

The latest version of v1 contains a number of deprecations, so we recommend upgrading to the latest version of v1 first.

## Breaking changes

### `template` → `view_template`

Instead of defining the `template` method for your component templates, you should instead define `view_template`.

### `template_tag` → `template`

To render [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template) elements in a `Phlex::HTML` component, you need to call the `template` method instead of the original `template_tag` method.

### We removed `tokens` and `classes`

There are better ways to handle conditional tokens now, so we removed these helpers. If you need them back to support your existing code, you can copy their original implementation from below.

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

## New features

### Kits

Originally previewed in v1, kits are now out of beta and fully supported in v2. Kits are a way to package up a set of components into a module.

### Selective rendering

### A better cache

Phlex v2 introduces a new attribute cache that caches more things. We wrote about some of the technical details [here](/design/caching).
