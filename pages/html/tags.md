---
title: HTML Tags
---

# HTML Tags

`Phlex::HTML` comes with methods that correspond to the most common HTML tags. You’ve seen the `h1` tag in the previous section.


## Content

You pass content as a block to a tag method. If the return value of the block is a `String`, `Symbol`, `Integer` or `Float`, it will be output as *text*.

```phlex
example do |e|
	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def template
				h1 { "👋 Hello World!" }
			end
		end
	RUBY

	e.execute "Hello.new.call"
end
```

## Attributes

You can add attributes to HTML elements by passing keyword arguments to the methods.

```phlex
example do |e|
	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def template
				h1(class: "text-xl font-bold") { "👋 Hello World!" }
			end
		end
	RUBY

	e.execute "Hello.new.call"
end
```

Underscores `_` are automatically converted to dashes `-` for `Symbol` keys. If you need to use an underscore in an attribute name, you can pass it as a `String`.

```phlex
example do |e|
	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def template
				h1("foo_bar" => "hello") { "👋 Hello World!" }
			end
		end
	RUBY

	e.execute "Hello.new.call"
end
```

## Hash attributes

You can pass a `Hash` as an attribute value and the Hash will be flattened with a dash between each level.

```phlex
example do |e|
	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def template
				div(data: { controller: "hello" }) do
					# ...
				end
			end
		end
	RUBY

	e.execute "Hello.new.call"
end
```


## Boolean attributes

When an attribute value is `true`, the attribute name will be output without a value; when _falsy_, the attribute isn’t output at all. You can use the strings `"true"` and `"false"` as values for non-boolean attributes.

```phlex
example do |e|
	e.tab "channel_controls.rb", <<~RUBY
		class ChannelControls < Phlex::HTML
			def template
				input(
					value: "1",
					name: "channel",
					type: "radio",
					checked: true
				)

				input(
					value: "2",
					name: "channel",
					type: "radio",
					checked: false
				)
			end
		end
	RUBY

	e.execute "ChannelControls.new.call"
end
```

## The template tag

Because the `template` method is used to define the view template itself, you'll need to use the method `template_tag` if you want to to render an HTML `<template>` tag.

```phlex
example do |e|
	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			def template
				template_tag do
					img src: "hidden.jpg", alt: "A hidden image."
				end
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```

## Registering custom tags

You can register custom elements with the `register_element` macro. The custom element will only be available in the view where it is registered and subclasses of that view.

```phlex
example do |e|
	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			register_element :trix_editor

			def template
				trix_editor input: "content", autofocus: true
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```
