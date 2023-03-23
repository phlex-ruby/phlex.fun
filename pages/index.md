---
title: Phlex — fast, object-oriented view framework for Ruby
---

# Introduction

Phlex is a framework for building fast, reusable, testable object-oriented views in Ruby. It’s thread-safe and supports [MRI/CRuby](https://www.ruby-lang.org/en/) v2.7+, [TruffleRuby](https://www.graalvm.org/ruby/) v22.2+ and [JRuby](https://www.jruby.org) v9.2+.

HTML is described using simple Ruby constructs: *methods*, *keyword arguments* and *blocks*.

```ruby
nav(class: "main-nav") {
	ul {
		li { a(href: "/") { "Home" } }
		li { a(href: "/about") { "About" } }
		li { a(href: "/contact") { "Contact" } }
	}
}
```

Writing views in Ruby means we don’t need to switch between multiple languages for templates with dynamic content. We can iterate through a list and output HTML for each item, for example, without any context switching.

```ruby
@articles.each do |article|
	h2 { article.title }
end
```

The ERB equivalent uses both Ruby and HTML in adition to a third language (ERB) to handle switching between the first two.

```erb
<% @articles.each do |article| %>
	<h2><%= article.title %></h2>
<% end %>
```

Using Ruby also means we can apply the same object-oriented [refactoring patterns](https://refactoring.com/catalog/) to our views that we use for the rest of our application.


## It’s not just templating

Phlex templates always belong to *objects* which provide an isolated execution context where only the instance variables and methods for that specific object are exposed to the template. This design eliminates an [entire category of bugs](https://andycroll.com/ruby/only-use-locals-in-view-partials/).

Here’s a view class that renders an `<h1>` tag with a greeting:

```ruby
class HelloComponent < Phlex::HTML
	def initialize(name:)
		@name = name
	end

	def template
		h1 { "👋 Hello #{@name}!" }
	end
end
```

These objects (let’s call them components) can represent anything from small pieces of user-interface to full pages and layouts.

After initialising a component object, you can render it to HTML with the `call` method.

```ruby
HelloComponent.new(name: "Joel").call
```
```html
<h1>👋 Hello Joel!</h1>
```

You can also render components in other components using the `render` method. Let’s define a component that renders the `HelloComponent` with a couple of different names:

```ruby
class ExampleComponent < Phlex::HTML
	def template
		["Jack", "Jill"].each do |name|
			render HelloComponent.new(name:)
		end
	end
end
```

You’ll notice we’ve been inheriting from `Phlex::HTML`. You can also inherit from `Phlex::SVG` to build dynamic SVG components.
