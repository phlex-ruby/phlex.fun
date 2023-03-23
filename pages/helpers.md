---
title: Helpers
---

## Conditional tokens

The `tokens` method helps you define conditional HTML attribute tokens such as CSS classes. You can use it to combine multiple tokens together.

```ruby
tokens("a", "b", "c")

# → "a b c"
```

You can use keyword arguments to specify conditions for specific tokens. A condition can be a `Proc` that returns a *truthy/falsy* value:

```ruby
tokens(
	-> { true } => "foo",
	-> { false } => "bar"
)

# → "foo"
```

Alternatively, the condition can be a `Symbol` that coresponds to the name of a predicate method:

```ruby
tokens(active?: "active")
```

You can also use a Hash with `:then` and `:else` keys as speical ternary syntax:

```ruby
tokens(active?: { then: "active", else: "inactive" })
```

Here we have a `Nav::Link` component that produces an `<a>` tag with the CSS class `nav-item`. If the link is _active_, we also apply the CSS class `active`.

```ruby
class Nav::Link < Phlex::HTML
	def initialize(to:)
		@to = to
	end

	def template(&content)
		a(href: @to,
			class: tokens("nav-item", active?: "active"),
			&content
		)
	end

	private

	def active? = helpers.current_page?(@to)
end
```
