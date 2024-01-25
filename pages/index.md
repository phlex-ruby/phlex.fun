---
title: Phlex — fast, object-oriented view framework for Ruby
---

# Introduction

Phlex is a Ruby gem for building fast object-oriented HTML and SVG components. It’s thread-safe and supports [MRI/CRuby](https://www.ruby-lang.org/en/) v2.7+, [TruffleRuby](https://www.graalvm.org/ruby/) v22.2+ and [JRuby](https://www.jruby.org) v9.2+.

Views are described using simple Ruby constructs: *methods*, *keyword arguments* and *blocks*. For example, this is how you might describe an HTML `<nav>` with a list of links:

```ruby
nav(class: "main-nav") do
	ul do
		li { a(href: "/") { "Home" } }
		li { a(href: "/about") { "About" } }
		li { a(href: "/contact") { "Contact" } }
	end
end
```

The above Ruby source would produce the following HTML markup:

```html
<nav class="main-nav">
	<ul>
		<li><a href="/">Home</a></li>
		<li><a href="/about">About</a></li>
		<li><a href="/contact">Contact</a></li>
	</ul>
</nav>
```

Using a Ruby DSL means we don’t need to switch between different languages when writing templates with dynamic content. For example, we can iterate through a list and output HTML for each item without any context switching.

```ruby
@articles.each do |article|
	h2 { article.title }
end
```

To do this in ERB, you would need to use three different languages — **ERB**, **HTML** and **Ruby** — in the same file.

```erb
<% @articles.each do |article| %>
	<h2><%= article.title %></h2>
<% end %>
```


## Components

Phlex encourages you to break up your views into small, testable, reusable objects called components. Each component class has a `template` method, which determiens its output. Components can also render other components.

Let’s create a class called `HelloComponent` with a template that renders an `<h1>` tag with the content “👋 Hello World!”.

```ruby
class HelloComponent < Phlex::HTML
	def template
		h1 { "👋 Hello World!" }
	end
end
```
```html
<h1>👋 Hello World!</h1>
```

Notice how we can just return a string from the content block? When no other nodes are present, the return value of the block is used as the content of the tag.

If you want to output plain text without wrapping it in an element, you can use the `plain` method.

```ruby
def template
	h1 do
		plain "👋 Hello "
		strong { "World!" }
	end
end
```
```html
<h1>👋 Hello <strong>World</strong></h1>
```

All text output is HTML-escaped, so it’s safe for user-generated content.

## Nodes

### Whitespace

For the purpose of this documentation, we’ve been formatting the HTML output with indentation to make it easier to read. Howev
er, Phlex doesn’t add any whitespace to the output by default. If you want to add whitespace, you can use the `whitespace` method.

This is useful for adding between _inline_ elements to allow them to wrap. For example, if these links were inline, they would overflow the container rather than wrap if we didn’t use whitespace.

```ruby
class FooterLinksComponent < Phlex::HTML
	def template
		a(href: "/") { "Home" }
		whitespace
		a(href: "/about") { "About" }
		whitespace
		a(href: "/contact") { "Contact" }
	end
end
```

When called without a block, `whitespace` outputs a single space character. If you pass a block, the content is wrapped with space character on either side.

```ruby
whitespace { a(href: "/") { "Home" } }
```

### Doctype

You can output an HTML 5 doctype with the `doctype` method.

```ruby
doctype
```
```html
<!DOCTYPE html>
```

### Comments

The `comment` method wraps the content in comment tags.

```ruby
comment { "Hello" }
```
```html
<!-- Hello -->
```

### Raw HTML

If you want to output raw HTML without escaping it, you can use the `unsafe_raw` method.

You should only use this method if you’re sure the content is safe because Phlex provides no protection against XSS (cross-site-scripting) attacks when using `unsafe_raw`.

```ruby
unsafe_raw "<strong>Hello</strong>"
```
```html
<strong>Hello</strong>
```

### Capturing output

If you want to capture the output of a block as a String, you can use the `capture` method.

In this example, the `captured_html` variable will be set to the string `"<h1>Hello</h1>"`. You probably won’t need to use this method, but it can be helpful for building advanced components.

```ruby
captured_html = capture do
	h1 { "Hello" }
end
```

### Custom elements

To create custom elements, use the `register_element` macro. For example, you can register the `<trix-editor>` element like this:

```ruby
class Example < Phlex::HTML
	register_element :trix_editor

	def template
		trix_editor
	end
end
```

Underscores in the method name are converted to dashes, so `trix_editor` becomes `<trix-editor>`. Calling this component would output the following:

```html
<trix-editor></trix-editor>
```

Custom elements are not registered globally, so you can’t use an element that was registered in class `A` in class `B`, but they can be shared through inheritance.

Here, `Example` can use `trix_editor` because it inherits from `Base` where the element was registered:

```ruby
class Base < Phlex::HTML
	register_element :trix_editor
end
```
```ruby
class Example < Base
	def template
		trix_editor
	end
end
```

Alternatively, custom elements can be shared by including a module that extends `Phlex::Elements`:

```ruby
module MyElements
	extend Phlex::Elements

	register_element :trix_editor
end
```
```ruby
class Example < Phlex::HTML
	include MyElements

	def template
		trix_editor
	end
end
```

The `Phlex::Elements` module provides the `register_element` macro to define element methods. However, these methods will only work on a class that also inherits from `Phlex::HTML` or `Phlex::SVG`.

## Rendering components

After initialising a component object, you can render it to HTML with the `call` method. If you’re using `phlex-rails` with Rails, you won’t need to use use `#call` directly since you can render components with the `render` method from controllers or other views.

First, let’s make a HelloComponent that takes a name and renders an `<h1>` with a greeting.

```ruby
class HelloComponent < Phlex::HTML
	def initialize(name:)
		@name = name
	end

	def template
		h1 { "Hello #{@name}" }
	end
end
```

Now we can render it by calling it.

```ruby
HelloComponent.new(name: "Joel").call
```
```html
<h1>👋 Hello Joel!</h1>
```

You can also render components from other components using the `render` method.

```ruby
class ExampleComponent < Phlex::HTML
	NAMES = ["Jack", "Jill"]

	def template
		NAMES.each do |name|
			render HelloComponent.new(name:)
		end
	end
end
```

## HTML attributes


[`Phlex::HTML`](https://www.rubydoc.info/gems/phlex/Phlex/HTML) defines instance methods that correspond to [HTML elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element). You can find a complete list of [standard elements](https://www.rubydoc.info/gems/phlex/Phlex/HTML/StandardElements) and [void elements](https://www.rubydoc.info/gems/phlex/Phlex/HTML/VoidElements) in the [API documentation](https://www.rubydoc.info/gems/phlex). If it’s missing an element that you need, please [open an issue on GitHub](https://github.com/phlex-ruby/phlex/issues/new).

Standard elements such as `<div>` and `<span>` accept nested content as a block, while void elements such as `<img>` and `<input>` do not. When passing a content block, you can either call other tag methods or return a value to output as text.

In this example, we call the `span` method in the `div` block and then return the value `"Hello"` in the `span` block.

```ruby
div do
	span { "Hello" }
end
```

We can’t combine these techniques like this:

```ruby
div do
	"Hello "
	strong { "World" }
	"!"
end
```

Instead, we can use the `plain` method to output plain text.


```ruby
div do
	plain "Hello "
	strong { "World" }
	plain "!"
end
```

## Attributes

All tag methods accept HTML attributes as keyword arguments:

```ruby
div(class: "foo")
```
```html
<div class="foo"></div>
```

When using `Symbol` keys, underscores are replaced with dashes, so the key `:data_controller` becomes the attribute `data-controller`:

```ruby
div(data_controller: "foo")
```
```html
<div data-controller="foo"></div>
```

When using `String` keys, underscores are not replaced. The key `"data_controller"` is the attribute `data_controller`. I can’t think of a good reason to use underscores in HTML attribute names, but you have the option.

```ruby
div("data_controller" => "foo")
```
```html
<div data_controller="foo"></div>
```

`Hash` values are flattened with dashes.

```ruby
div(data: { controller: "foo" })
```
```html
<div data-controller="foo"></div>
```

`true` values are omitted.

```ruby
input(disabled: true)
```
```html
<input disabled>
```

*Falsy* values (`false` or `nil`) skip the attribute entirely:

```ruby
input(disabled: false)
```
```html
<input>
```

Some HTML attributes may *look* like boolean attributes, but they’re actually enums. The ARIA attribute [`aria-invalid`](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-invalid), for example, must be `"true"`, `"false"`, `"spelling"` or `"grammar"`.

For this attribute, you should use the strings `"true"` or `"false"` rather than the boolean literals `true` or `false`.

```ruby
input(aria_invalid: "true")
```
```html
<input aria-invalid="true">
```

# Advanced Phlex

## Hooks and callbacks

Phlex provides a number of hooks and callbacks that allow you to customise the behaviour of components.
