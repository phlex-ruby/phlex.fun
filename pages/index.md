---
title: Phlex — fast, object-oriented view framework for Ruby
---

# Phlex 💪

Phlex is a [Ruby gem](https://rubygems.org/gems/phlex) for building fast object-oriented HTML and SVG components. Views are described using Ruby constructs: *methods*, *keyword arguments* and *blocks*, which directly correspond to the output. For example, this is how you might describe an HTML `<nav>` with a list of links:

```phlex
class Nav < Phlex::HTML
  def template
    nav(class: "main-nav") {
		 	ul {
				li { a(href: "/") { "Home" } }
				li { a(href: "/about") { "About" } }
				li { a(href: "/contact") { "Contact" } }
			}
		}
  end
end
```
```phlexecute
render Nav
```

## Why render HTML in Ruby?

Building components in Ruby makes it possible to build powerful abstractions. The `Nav` menu above could be refactored into a Ruby class to allow developers to add items to the menu without needing to understand the underlying HTML.

```phlex
class Nav < Phlex::HTML
  def template(&content)
  	nav(class: "main-nav") {
			ul(&content)
  	}
  end

  def item(url, &content)
  	li { a(href: url, &content) }
  end
end
```
```phlexecute
render Nav.new do |nav|
	nav.item("/") { "Home" }
	nav.item("/about") { "About" }
	nav.item("/contact") { "Contact" }
end
```

The component can be called from Ruby or Erb without a bunch of `<% %>` tags.

```ruby
render Nav.new do |nav|
	nav.item("/") { "Home" }
	nav.item("/about") { "About" }
	nav.item("/contact") { "Contact" }
end
```

Since the component is just a Ruby class, it can be extended with inheritence and modules. Let's create a subclass that works with Tailwind CSS.

```phlex
class TailwindNav < Nav
	def template(&content) = nav(class: "flex flex-row gap-4", &content)

	def item(url, &content)
	  a(href: url, class: "text-underline", &content)
	end
end
```
```phlexecute
render TailwindNav.new do |nav|
	nav.item("/") { "Home" }
	nav.item("/about") { "About" }
	nav.item("/contact") { "Contact" }
end
```


Your view data, code, and markup live together in the same place making it easier to reason through an application's UI. Since views are just Ruby, you get more flexibility than templating languages like Erb, Slim, Haml, and Liquid.

### What’s a view?
Views are Ruby objects that represent a piece of output from your app. We plan to support various different types of output — such as JSON, XML and SVG — but for now, we’re focusing on HTML.

Views can have an `initialize` method that dictates which arguments the view accepts and is responsible for setting everything up — usually assigning instance variables for use in the template.

The template is a special method that’s called when rendering a view. The `template` method determines the output of the view by calling methods that append to the output.

Instance methods perform important calculations or encapsulate a small part of the template. Public instance methods can expose an interface that’s yielded to the parent when rendering.

### Installation

Install Phlex to your project by running:

```sh
$ bundle add phlex
```

This will add the following to your Gemfile:

```ruby
gem "phlex"
```

and automatically run `bundle install`

# HTML
## HTML Views
You can create an HTML view by subclassing `Phlex::HTML` and defining a `template` instance method.

```phlex
class Hello < Phlex::HTML
	def template
		h1 { "👋 Hello World!" }
	end
end
```
```phlexecute
render Hello
```

The `template` method determines what your view will output when its rendered. The above example calls the `h1` method which outputs an `<h1>` tag.

### Accepting arguments

You can define an _initializer_ for your views just like any other Ruby class. Let’s make our `Hello` view take a `name` as a keyword argument, save it in an instance variable and render that variable in the template.

We’ll render this view with the arguments `name: "Joel"` and see what it produces.

```phlex
class Hello < Phlex::HTML
	def initialize(name:)
		@name = name
	end

	def template
		h1 { "👋 Hello #{@name}!" }
	end
end
```
```phlexecute
render Hello.new(name: "Joel")
```

### Rendering views

Views can render other views in their templates using the `render` method. Let's try rendering a couple of instances of this `Hello` view from a new `Example` view and look at the output of the `Example` view.

```phlex
class Example < Phlex::HTML
	def template
		render Hello.new(name: "Joel")
		render Hello.new(name: "Alexandre")
	end
end
```
```phlexecute
render Example
```


### Content
Views can also yield content blocks, which can be passed in when rendering. Let's make a `Card` component that yields content in an `<article>` element with a `drop-shadow` class on it.

```phlex
class Card < Phlex::HTML
	def template
		article(class: "drop-shadow") {
			yield
		}
	end
end
```
```phlex
class Example < Phlex::HTML
	def template
		render(Card.new) {
			h1 { "👋 Hello!" }
		}
	end
end
```
```phlexecute
render Example
```

The `Example` view renders a `Card` and passes it a block with an `<h1>` tag.

Looking at the output of the `Example` view, we can see the `<h1>` element was rendered inside the `<article>` element from the `Card` view.

### Delegating content
Since the block of content was the only thing we need in the `<article>` element, we could have just passed the content block directly to the element instead.

```ruby
class Card < Phlex::HTML
	def template(&)
		article(class: "drop-shadow", &)
	end
end
```

### Hooks
[//]: # (We should also add an example of around_template)

You can hook into the rendering process by overriding `before_template` and `after_template` which are called immediately before and after the template is rendered.

You should always call `super` from these methods to allow for inherited callbacks.

```phlex
class Example < Phlex::HTML
	def before_template
		h1 { "Before" }
		super
	end

	def template
		h2 { "Hello World!" }
	end

	def after_template
		super
		h3 { "After" }
	end
end
```
```phlexecute
render Example
```

# Tags
## HTML Tags
`Phlex::HTML` comes with methods that correspond to the most common HTML tags. You’ve seen the `h1` tag in the previous section.

### Content
You pass content as a block to a tag method. If the return value of the block is a `String`, `Symbol`, `Integer` or `Float` and no output methods were used, the return value will be output as _text_.

```phlex
class Greeting < Phlex::HTML
	def template
		h1 { "👋 Hello World!" }
	end
end
```
```phlexecute
render Greeting
```

### Attributes
You can add attributes to HTML elements by passing keyword arguments to the methods.

```phlex
class Greeting < Phlex::HTML
	def template
		h1(class: "text-xl font-bold") { "👋 Hello World!" }
	end
end
```
```phlexecute
render Greeting
```

Underscores `_` are automatically converted to dashes `-` for `Symbol` keys. If you need to use an underscore in an attribute name, you can use a `String` key instead.

```phlex
class Greeting < Phlex::HTML
	def template
		h1(foo_bar: "hello") { "👋 Hello World!" }
		h1("foo_bar" => "hello") { "👋 Hello World!" }
	end
end
```
```phlexecute
render Greeting
```

### Hash attributes
You can pass a `Hash` as an attribute value and it will be flattened with a dash `-` between each level.

```phlex
class Greeting < Phlex::HTML
	def template
		div(data: { controller: "hello" }) {
			# ...
		}
	end
end
```
```phlexecute
render Greeting
```

### Boolean attributes
When an attribute value is `true`, the attribute name will be output without a value; when _falsy_, the attribute isn’t output at all. You can use the strings `"true"` and `"false"` as values for non-boolean attributes.

```phlex
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
```
```phlexecute
render ChannelControls
```

### The template tag
Because the `template` method is used to define the view template itself, you'll need to use the method `template_tag` if you want to to render an HTML `<template>` tag.

```phlex
class TemplateExample < Phlex::HTML
	def template
		template_tag {
			img src: "hidden.jpg", alt: "A hidden image."
		}
	end
end
```
```phlexecute
render TemplateExample
```

### Registering custom tags
You can register custom elements with the `register_element` macro. The custom element will only be available in the view where it is registered and subclasses of that view.

```phlex
class CustomTagExample < Phlex::HTML
	register_element :trix_editor

	def template
		trix_editor input: "content", autofocus: true
	end
end
```
```phlexecute
render CustomTagExample
```

# Helpers
## HTML Helpers
### Stand-alone text
You can output text content without wrapping it in an element by using the `plain` method. It accepts a single argument which can be a `String`, `Symbol`, `Integer` or `Float`.

```phlex
class Heading < Phlex::HTML
	def template
		h1 do
			strong { "Hello " }
			plain "World!"
		end
	end
end
```
```phlexecute
render Heading
```

### Whitespace

If you need to add whitespace, you can use the `whitespace` method. This is useful for adding space between _inline_ elements to allow them to wrap.

```phlex
class Links < Phlex::HTML
	def template
		a(href: "/") { "Home" }
		whitespace
		a(href: "/about") { "About" }
		whitespace
		a(href: "/contact") { "Contact" }
	end
end
```
```phlexecute
render Links
```

If you pass a block to `whitespace`, the content is wrapped in whitespace on either side.

```ruby
whitespace { a(href: "/") { "Home" } }
```

### Comments
The `comment` method takes a block and wraps the content in an HTML comment.

```ruby
comment { "Hello" }
```

### Conditional tokens
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
```
```phlex
class TokensExample < Phlex::HTML
	def template
		nav {
			ul {
				li { render Link.new("Home", to: "/", active: true) }
				li { render Link.new("About", to: "/about", active: false) }
			}
		}
	end
end
```
```phlexecute
render TokensExample
```

### Conditional classes
The `classes` method helps to create a token list of CSS classes. This method returns a `Hash` with the key `:class` and the value as the result of `tokens`, allowing you to destructure it into a keyword argument using the `**` prefix operator.

```phlex
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
```
```phlex
class ClassesExample < Phlex::HTML
	def template
		nav {
			ul {
				li { render Link.new("Home", to: "/", active: true) }
				li { render Link.new("About", to: "/about", active: false) }
			}
		}
	end
end
```
```phlexecute
render ClassesExample
```

### Unsafe output
`unsafe_raw` takes a `String` and outputs it without any safety or HTML escaping. You should _never_ use this method with any string that could come from an untrusted person. In fact, you should pretty much never use this method. If you do, don’t come crying when someone hacks your website.

If you think you need to use `unsafe_raw`, maybe [open a discussion thread](https://github.com/phlex-ruby/phlex/discussions/new) for other ideas.

# Slots

You can build reusable & composable Phlex views.

For example, you may need to define multiple sections (slots) in a view. This can be accomplished by defining public instance methods on the view that accept blocks:

```phlex
class Card < Phlex::HTML
	def template(&)
		article(class: "card", &)
	end

	def title(&)
		div(class: "title", &)
	end

	def body(&)
		div(class: "body", &)
	end
end
```
```phlex
class CardExample < Phlex::HTML
	def template
		render Card.new do |card|
			card.title do
				h1 { "Title" }
			end

			card.body do
				p { "Body" }
			end
		end
	end
end
```
```phlexecute
render CardExample
```

This would work just fine for a list of views as each method can be called multiple times.

One caveat of defining the view this way is `title` and `body` could be called in any order. This offers flexibility, but what if you need to make sure your markup is output in a consistent order?

First, include `Phlex::DeferredRender` in your view. This changes the behavior of `template` so it does not receive a block and is yielded early. Then use public methods to save blocks, passing them to back to the `template` at render time.

```phlex
class List < Phlex::HTML
	include Phlex::DeferredRender

	def initialize
		@items = []
	end

	def template
		if @header
			h1(class: "header", &@header)
		end

		ul do
			@items.each do |item|
				li { render(item) }
			end
		end
	end

	def header(&block)
		@header = block
	end

	def with_item(&content)
		@items << content
	end
end
```
```phlex
class ListExample < Phlex::HTML
	def template
		render List.new do |list|
			list.header do
				"Header"
			end

			list.with_item do
				"One"
			end

			list.with_item do
				"two"
			end
		end
	end
end
```
```phlexecute
render ListExample
```

# Testing Introduction
## Testing Phlex Views
The `Phlex::Testing::ViewHelper` module defines render allowing you to render Phlex views directly in your tests and make assertions against the output.

You’ll need to require `phlex/testing/view_helper` and include `Phlex::Testing::ViewHelper` your test.

```ruby
require "phlex/testing/view_helper"

class TestHello < Minitest::Test
	include Phlex::Testing::ViewHelper

	def test_hello_output_includes_name
		output = render Hello.new("Joel")
		assert_equal "<h1>Hello Joel</h1>", output
	end
end
```
```ruby
class Hello < Phlex::HTML
	def initialize(name)
		@name = name
	end

	def template
		h1 { "Hello #{@name}" }
	end
end
```

# Nokogiri
## Testing HTML Views with Nokogiri [beta]
The [`phlex-testing-nokogiri`](https://rubygems.org/gems/phlex-testing-nokogiri) gem provides helpers for working with rendered views as [Nokogiri](https://nokogiri.org/) documents and fragments.

### Installation
Add the following to the test group in your Gemfile and run `bundle install`.

```ruby
gem "phlex-testing-nokogiri"
```

### Testing Documents
If your view represents a whole HTML document, you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::DocumentHelper` module to render your view as `Nokogiri::Document` using the `render` method.

```ruby
require "phlex/testing/nokogiri"

class TestExample < Minitest::Test
	include Phlex::Testing::Nokogiri::DocumentHelper

	def test_example
		output = render Example.new
		assert_equal "Hello Joel", output.css("h1").text
	end
end
```
```ruby
class Hello < Phlex::HTML
	def initialize(name)
		@name = name
	end

	def template
		h1 { "Hello #{@name}" }
	end
end
```

### Testing Fragments
If your view represents a fragment (partial), you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::FragmentHelper` module to render your view as `Nokogiri::Fragment` with the `render` method.

```ruby
require "phlex/testing/nokogiri"

class TestExample < Minitest::Test
	include Phlex::Testing::Nokogiri::FragmentHelper

	def test_example
		output = render Example.new("Joel")
		assert_equal "Hello Joel", output.css("h1").text
	end
end
```
```ruby
class Hello < Phlex::HTML
	def initialize(name)
		@name = name
	end

	def template
		h1 { "Hello #{@name}" }
	end
end
```

# Capybara
## Testing with Capybara [beta]
The [`phlex-testing-capybara`](https://rubygems.org/gems/phlex-testing-capybara) gem provides a test helper that lets you use [Capybara](http://teamcapybara.github.io/capybara/) matchers.

### Installation
Add the following to the test group in your Gemfile and run `bundle install`.

```ruby
gem "phlex-testing-capybara"
```

### Usage
You’ll need to require `phlex/testing/capybara` and include `Phlex::Testing::Capybara::ViewHelper`.

The `render` method will return a `Capybara::Node::Simple` and set the `page` attribute to the result.

```ruby
require "phlex/testing/capybara"

class TestExample < Minitest::Test
	include Phlex::Testing::Capybara::ViewHelper

	def test_example
		render Example.new("Joel")
		assert_selector "h1", text: "Hello Joel"
	end
end
```
```ruby
class Hello < Phlex::HTML
	def initialize(name)
		@name = name
	end

	def template
		h1 { "Hello #{@name}" }
	end
end
```

# Testing Rails
## Testing Phlex views in Rails
When you include `Phlex::Testing::Rails::ViewHelper`, views rendered in the test will have a view context, so they can use Rails helpers.

# Rails Introduction
## Getting started with Phlex on Rails
While Phlex can be used in any Ruby project, it’s especially great with [Rails](https://rubyonrails.org/). But before we get into the details, it’s important to understand that Phlex is very different from [ActionView](https://guides.rubyonrails.org/action_view_overview.html) and [ViewComponent](https://viewcomponent.org/).

### Setup
To use Phlex with Rails, you’ll need to install the [`phlex-rails`](https://rubygems.org/gems/phlex-rails) gem. Add the following to your Gemfile and run bundle install.

```ruby
gem "phlex-rails"
```

Note, you do not need to install `phlex` separately because `phlex` is a dependency of `phlex-rails`.

Once the gem is installed, run the install generator.

```bash
bin/rails generate phlex:install
```

This script will:

1. update `config/application.rb` to include `app/views`, `app/views/components`, and `app/views/layouts` in your auto-load paths;
2. generate `views/application_view.rb`
3. generate `views/layouts/application_layout.rb`
4. generate `views/components/application_component.rb`

`ApplicationComponent` is your base component which all your other components inherit from. By default, `ApplicationView` inherits from `ApplicationComponent`.

# Generators
## Rails Generators
### Component
```bash
bin/rails g phlex:component Card
```

This will generate a `CardComponent` in `card_component.rb` under `app/views/components`.

### View
```bash
bin/rails g phlex:view Articles::Index
```

This will generate an `Articles::IndexView` in `index_view.rb` under `app/views/articles`.

### Controller
```bash
bin/rails g phlex:controller Articles index show
```

This will generate an `ArticlesController` in `app/controllers`. It will have the actions `index` and `show`, which will render the views `Articles::IndexView` and `Articles::ShowView` generated in `index_view.rb` and `show_view.rb` under `app/views/articles`.

# Rendering Views
## Render Phlex views in Rails
You can render a Phlex view from your Rails controller actions or other views — Phlex, ActionView or ViewComponent.

Instead of implicitly rendering an ERB template with automatic access to all your controller instance variables, you’ll need to explicitly render Phlex views from your controller action methods.

```ruby
class ArticlesController < ApplicationController
	layout -> { ApplicationLayout }

	def index
		render Articles::IndexView.new(
			articles: Article.all.load_async
		)
	end

	def show
		render Articles::ShowView.new(
			article: Article.find(params[:id])
		)
	end
end
```

# Layouts
## Layouts in Rails
If you ran the install generator, you should have an `ApplicationLayout` file under `app/views/layouts/application_layout.rb`.

You can configure a controller to use this layout with the `layout` method. Phlex layouts are even compatible with non-Phlex views.

```ruby
class FooController < ApplicationController
	layout -> { ApplicationLayout }

	def index
		render Foo::IndexView
	end
end
```

### Yielding content
Rails doesn't provide a mechanism for passing arguments to a layout component, but your layout can `yield` content provided by `content_for`.

```ruby
class ApplicationLayout < Phlex::HTML
	include Phlex::Rails::Layout

	def template
		doctype

		html do
			head do
				title { yield(:title) }
			end

			body do
				yield
			end
		end
	end
end
```

# Helpers
## Using Rails Helpers
Phlex aims to ship with an adapter for every Rails view helper. (Please open an issue if we're missing one.)

Each adapter can be included from its own module under `Phlex::Rails::Helpers`, e.g. `Phlex::Rails::Helpers::ContentFor`. The module name will match the title-cased method name.

You can include these adapters as needed, or include the ones you use most commonly in `ApplicationComponent` or `ApplicationView`.

If you need to call the original unadapted helper, you can do that through the `helpers` proxy. For example, `helpers.link_to "Home", "/"` will return the HTML link as a String, while the adapter would output it.

# Migrating to Phlex
## Migrating an existing Rails app to Phlex
Whether you currently use ActionView or ViewComponent with ERB, HAML or Slim, you can start using Phlex in your Rails app today without a big rewrite.

### You can render Phlex views into existing templates
Phlex views implement the _renderable_ interface for Rails, which means they can be rendered from a controller or another view template — even ViewComponent templates. This means you can gradually migrate specific views and components to Phlex without having to change everything at once.

If you're migrating from ViewComponent, you might find you can convert components to Phlex views without even changing any call-sites.

### You can render ActionView partials and ViewComponent components in Phlex views
The `render` method in Phlex doesn't only work with Phlex views. You can use it to render ActionView partials and ViewComponent components.

### Use an ERB → Phlex converter
The ERB → Phlex converter, [Phlexing](https://www.phlexing.fun/), can do the heavy-lifting but it won't help you architect your components / design system.
