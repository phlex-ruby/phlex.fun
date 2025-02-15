# Upgrading to Phlex v2

While we’ve tried to keep breaking changes to a minimum, there are a few things you will need to be aware of when upgrading from Phlex v1 to v2.

The latest version of v1 contains a number of deprecations, so we recommend upgrading to the latest version of v1 first.

## Dropping SemVer for BreakVer

Phlex v1 used [SemVer](https://semver.org) (semantic versioning). Going forward, Phlex v2 and up will use [BreakVer](https://www.taoensso.com/break-versioning) instead. BreakVer will allow us to release changes more frequently because we can distinguish between _major_ breaking changes and _minor_ breaking changes.

The version scheme is:

```
MAJOR . MINOR . NON_BREAKING
```

- `NON_BREAKING` changes should always be safe to apply. They can include new features, enhancements, refactors and bug fixes, but they should never include any breaking changes.
- `MINOR` changes might break code in a _minor_ way — usually in a way that can be easily accommodated with a few minutes of mostly find/replace-type work.
- `MAJOR` changes might break code in a _major_ way. These are milestone releases.

We try to avoid breaking changes altogether, but they are sometimes necessary for progress. We’ve come to realize if we’re going to make a breaking change, we should make it _as quickly as possible_. Any delay means more work for users.

## Kits <Badge type="tip" text="new" />

Originally previewed in v1, Kits are now out of beta and fully supported in v2. Kits are a way to package up a set of components into a module, which makes them easier to render.

In v2, Kits also extend to modules (but not classes) defined under them.

```ruby
module Components
  extend Phlex::Kit

  module Articles
    # this is automatically upgraded to a kit

    class List < Phlex::HTML
      # this is available on the `Components::Articles` kit
    end
  end
end
```

[More details…](/components/kits.html)

## A better attribute cache <Badge type="tip" text="new" />

Phlex v2 introduces a new attribute cache that caches more things.

[More details…](/design/caching).

## Renamed `template` → `view_template` <Badge type="danger" text="breaking" />

Instead of defining the `template` method for your component templates, you should instead define `view_template`. This was renamed so that the `template` method can be used for `<template>` HTML tags.

## Renamed `template_tag` → `template` <Badge type="danger" text="breaking" />

To render [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template) elements in a `Phlex::HTML` component, you need to call the `template` method instead of `template_tag`.

## Removed `tokens` and `classes` <Badge type="danger" text="breaking" />

There are [better ways to handle conditional tokens now](/sgml/attributes.html#arrays-and-sets), so we removed these helpers. If you need them back to support your existing code, you can just copy the original implementation from below.

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

def __append_token__(tokens, token)
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

## Renamed `unsafe_raw` → `raw` <Badge type="danger" text="breaking" />

We’ve renamed `unsafe_raw` to `raw`, and it will now only output strings that are branded as being HTML-safe. You can use the new `safe` helper to mark content as safe. If you’re using Rails, `ActiveSupport::SafeBuffer` is also treated as safe.

```ruby
def view_template
  rendered_markdown = Commonmarker.to_html(@markdown) # [!code --]
  unsafe_raw rendered_markdown # [!code --]
  rendered_markdown = safe Commonmarker.to_html(@markdown) # [!code ++]
  raw rendered_markdown # [!code ++]
end
```

## Removed `DeferredRender` <Badge type="danger" text="breaking" />

`DeferredRender` was an odd combination of something that is easy to implement and hard to explain. We decided to remove it as a feature so that we don’t have to explain it. :innocent:

You can recreate the effect `DeferredRender` had with this module.

```ruby
module DeferredRender
  def before_template(&)
  	vanish(&)
  	super
  end
end
```

See [Yielding](/components/yielding.html) for an explanation how how this works.

## Changed selective rendering <Badge type="danger" text="breaking" />

We’ve redesigned the Selective Rendering feature (introduced in [1.10](https://github.com/phlex-ruby/phlex/releases/tag/1.10.0)) to be more predictable and easier to understand.

Previously, selective rendering worked by targeting element IDs:

```rb
# Before (Phlex ~> 1.10)
def view_template
  section do
    ul(id: "the-list") do  # Could target this by ID
      li { "Item 1" }
      li { "Item 2" }
    end
  end
end

# Usage:
component.call(fragments: ["the-list"])
```

Now, selective rendering requires explicit fragment declarations:

```rb
# After (Phlex 2.0)
def view_template
  section do
    fragment("the-list") do  # Explicitly declare renderable fragment [!code ++]
      ul(id: "the-list") do
        li { "Item 1" }
        li { "Item 2" }
      end
    end # [!code ++]
  end
end

# Usage remains the same:
component.call(fragments: ["the-list"])
```

**Key Differences:**

1. **Explicit Fragment Declaration**: Only content wrapped in `fragment(name) { ... }` can be selectively rendered
2. **Decoupled from DOM**: Fragment names no longer need to match element IDs
3. **More Predictable**: Eliminates edge cases where ID-based targeting wasn’t supported

### Common Use Case: Turbo Frames

For applications using Turbo Frames, you can automatically make all frames selectively renderable by extending the `turbo_frame` method:

```rb
def turbo_frame(id:, ...)
  fragment(id) { super }
end
```

This ensures any `<turbo-frame>` element can be selectively rendered using its ID.

## New opinionated Rails generators <Badge type="danger" text="breaking" />

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

You may want to run the new install generator in a fresh Rails app to see how the new folder structure works and assess if you want to adopt it.

The folder structure is entirely optional — you can put Phlex components wherever you like — but guides and generators may assume this structure.

## Changed rendering partials from Phlex <Badge type="danger" text="Rails" /><Badge type="danger" text="breaking" />

In order to support rendering plain strings, we removed the ability to render Rails partials like this:

```ruby
render "foo"
```

Now, you must use the `partial` method to create a partial reference object.

```ruby
render partial("foo")
```

These partial reference objects are also renderable outside of Phlex. You can pass them to ViewComponent components or other Rails partials.

[More details…](/components/rendering.html#rendering-rails-partials-in-phlex)
