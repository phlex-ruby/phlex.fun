---
title: HTML view helpers
---

# HTML Helpers

## Stand-alone text

You can output text content without wrapping it in an element by using the `text` method. It accepts a single argument which can be a `String`, `Symbol`, `Integer` or `Float`.

```phlex
example do |e|
	e.tab "heading.rb", <<~RUBY
		class Heading < Phlex::HTML
			def template
				h1 do
					strong { "Hello " }
					text "World!"
				end
			end
		end
	RUBY

	e.execute "Heading.new.call"
end
```

## Whitespace

If you need to add whitespace, you can use the `whitespace` method. This is useful for adding space between _inline_ elements to allow them to wrap.

```phlex
example do |e|
	e.tab "links.rb", <<~RUBY
		class Links < Phlex::HTML
			def template
				a(href: "/") { "Home" }
				whitespace
				a(href: "/about") { "About" }
				whitespace
				a(href: "/contact") { "Contact" }
			end
		end
	RUBY

	e.execute "Links.new.call"
end
```

If you pass a block to `whitespace`, the content is wrapped in whitespace on either side.

```ruby
whitespace { a(href: "/") { "Home" } }
```

## Comments
The `comment` method takes a block and wraps the content in an HTML comment.

```ruby
comment { "Hello" }
```

## Conditional tokens

The `tokens` method helps you define conditional HTML attribute tokens such as CSS classes. You can use it to combine multiple tokens together.

```ruby
tokens("a", "b", "c") # → "a b c"
```

You can use keyword arguments to specify the conditions for specific tokens. A condition can be a `Proc` or `Symbol` that maps to an instance method. The `:active?` Symbol for example maps to the `active?` instance method.

```ruby
tokens(
	-> { true } => "foo",
	-> { false } => "bar"
) # → "foo"
```

Here we have a `Link` view that produces an `<a>` tag with the CSS class `nav-item`. If the link is _active_, we also apply the CSS class `active`.

```phlex
example do |e|
	e.tab "link.rb", <<~RUBY
		class Link < Phlex::HTML
			def initialize(text, to:, active:)
				@text = text
				@to = to
				@active = active
			end

			def template
				a(href: @to, class: tokens("nav-item",
						active?: "active")) { @text }
			end

			private

			def active? = @active
		end
	RUBY

	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			def template
				nav do
					ul do
						li { render Link.new("Home", to: "/", active: true) }
						li { render Link.new("About", to: "/about", active: false) }
					end
				end
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```

## Conditional classes
The `classes` method helps to create a token list of CSS classes. This method returns a `Hash` with the key `:class` and the value as the result of `tokens`, allowing you to destructure it into a keyword argument using the `**` prefix operator.

```phlex
example do |e|
	e.tab "link.rb", <<~RUBY
		class Link < Phlex::HTML
			def initialize(text, to:, active:)
				@text = text
				@to = to
				@active = active
			end

			def template
				a(href: @to, **classes("nav-item",
					active?: "active")) { @text }
			end

			private

			def active? = @active
		end
	RUBY

	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			def template
				nav do
					ul do
						li { render Link.new("Home", to: "/", active: true) }
						li { render Link.new("About", to: "/about", active: false) }
					end
				end
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```

## Unsafe output

`unsafe_raw` takes a `String` and outputs it without any safety or HTML escaping. You should *never* use this method with any string that could come from an untrusted person. In fact, you should pretty much never use this method. If you do, don’t come crying when someone hacks your website.

If you think you need to use `unsafe_raw`, maybe [open a discussion thread](https://github.com/joeldrapper/phlex/discussions/new) for other ideas.
