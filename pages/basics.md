---
title: Basics
---
# Basics

## Templates

You can create a template by defining the `template` method on a `Phlex::HTML` or `Phlex::SVG` class. This method determines the output of your component when it’s rendered.

Let’s create a class called `Hello` with a template that renders an `<h1>` tag with the content “👋 Hello World!”.

```ruby
class Hello < Phlex::HTML
	def template
		h1 { "👋 Hello World!" }
	end
end
```

## Content

Elements accept nested content as a Ruby block argument. Within a content block, you can create other elements by calling their coresponding methods. Alternatively, if there are no nested elements, the return value of the content block will be treated as plain text content.

```ruby
def template
	nav {
		ul {
			li { a(href: "/") { "Home" } }
			li { a(href: "/about") { "About" } }
			li { a(href: "/contact") { "Contact" } }
		}
	}
end
```

Notice how we can just return the strings `"Home"`, `"About"` and `"Contact"` from the `a` blocks? Behind the scenes, Phlex checks if yielding the block changes the length of the output buffer, and if it doesn’t, treats the return value as plain text instead.

The output of this component in HTML is:

```html
<nav>
	<ul>
		<li><a href="/">Home</a></li>
		<li><a href="/about">About</a></li>
		<li><a href="/contact">Contact</a></li>
	</ul>
</nav>
```

## Plain text

We’ve seen how to output text content by returning a value form the content block passed to an element. If you want to output plain text without wrapping it in an element, you can use the `plain` method.

```ruby
def template
	h1 do
		plain "Hello "
		strong { "World!" }
	end
end
```

All text output is HTML-escaped so it’s safe to output user-generated content.

## Whitespace

If you need to add whitespace between elements, you can use the `whitespace` method. This is useful for adding space between _inline_ elements to allow them to wrap.

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

If you pass a block to `whitespace`, the content is wrapped with space on either side.

```ruby
whitespace { a(href: "/") { "Home" } }
```

## Comments

The `comment` method wraps the content in comment tags.

```ruby
comment { "Hello" }
```
