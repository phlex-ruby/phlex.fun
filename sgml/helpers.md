---
title: Phlex component helpers
---

# Helpers

Phlex provides two helpers for combining attribute hashes, and accessing keyword arguments.

## `mix`

It’s not uncommon that when building an abstract component like a Button or Card, that you will want to expose some level of control over the resulting HTML to the caller of your component. Possibly for the purpose of adding an ID, or some additional classes. Or maybe to attach behavior using a JS library like Stimulus or Alpine.js. All of this requires being able to modify the attributes being applied to the HTML _inside_ the component, from the _outside_.

We could do this by exposing every possible attribute that we want to allow being modified, and handling it manually.

```rb
class Card < Phlex::HTML
  def initialize(id: nil, data: {})
    @id = id
    @data = data
  end

  def view_template
    div(id: @id, data: @data) do
      # ...
    end
  end
end
```

But you can imagine how this can get out of hand quickly. This method does provide the most control of _what_ is allowed to be configured, and exactly _how_ that configuration gets applied. But many times it’s easiest to be hands-off and allow access to the attributes from the caller, and the `mix` helper can help you do that.

```rb
class Card < Phlex::HTML
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template
    div(**mix({ class: "card" }, @attributes)) do
      # ...
    end
  end
end
```

Now we can add any arbitrary attribute to the rendered Card.

```rb
render Card.new(id: "my-card")
render Card.new(data: { controller: "fancy-card" })
render Card.new(class: "purple-card")
```

`mix` will merge the attributes together, but instead of replacing old values with new values, it will treat them like token lists, and combine them. So it works great for combining class lists, or stimulus controllers. It handles all the attribute types that Phlex supports, so it can correctly mix a `{ class: ["a", "b", "c"] }`, with `{ class: "my-class" }`.

The hashes are merged in the order they are provided, so that the last item has the highest precedent.

It also supports completely overriding a previous value, by appending a key with a bang `!`.

```rb
mix({ class: "default classes" }, { class!: "only-use-this-class" })
#=> { class: "only-use-this-class" }
```

::: details `mix` source code

```rb
def mix(*args)
  args.each_with_object({}) do |object, result|
    result.merge!(object) do |_key, old, new|
      case [old, new].freeze
      in [Array, Array] | [Set, Set]
        old + new
      in [Array, Set]
        old + new.to_a
      in [Array, String]
        old + [new]
      in [Hash, Hash]
        mix(old, new)
      in [Set, Array]
        old.to_a + new
      in [Set, String]
        old.to_a + [new]
      in [String, Array]
        [old] + new
      in [String, Set]
        [old] + new.to_a
      in [String, String]
        "#{old} #{new}"
      in [_, nil]
        old
      else
        new
      end
    end

    result.transform_keys! do |key|
      key.end_with?("!") ? key.name.chop.to_sym : key
    end
  end
end
```

:::

## `grab`

Sometimes when you’re designing a component’s API, you want a keyword argument whose name _is_ a keyword. This presents a problem when you’re trying to access that keyword argument.

```rb
def initialize(class:)
  @class = class # 💥
end
```

Sure, you could work around this by slurping the offending keyword arguments into a hash, or by using `binding.local_variable_get`, or by :scream: picking a different name. Or you could just `grab` it.

`grab` is a simple helper that will return the value of the lone supplied keyword argument.

```rb
def initialize(class:)
  @class = grab(class:) # ✅
end
```

It can also return multiple values if you’re in the predicament of needing multiple things named after reserved words.

```rb
def initialize(class:, if:,)
  @class, @if = grab(class:, :if)
end
```

::: details `grab` source code

```rb
def grab(**bindings)
  if bindings.size > 1
    bindings.values
  else
    bindings.values.first
  end
end
```

<<<<<<< Updated upstream
:::

::: tip

You’ll probably never need to use `grab` if you use [Literal Properties](/miscellaneous/literal-properties) to generate your initializers, since it automatically escapes reserved keywords by default.

```ruby
prop :class, String
prop :if, Proc
```

=======
>>>>>>> Stashed changes
:::
