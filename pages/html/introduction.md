---
title: HTML Views in Phlex
---

# HTML Views

You can create an HTML view by subclassing `Phlex::HTML` and defining a `template` instance method.

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

The `template` method determines what your view will output when its rendered. The above example calls the `h1` method which outputs an `<h1>` tag. Switch to the “Output” tab above to see for yourself.

## Accepting arguments

You can define an *initializer* for your views just like any other Ruby class. Let’s make our `Hello` view take a `name` as a keyword argument, save it in an instance variable and render that variable in the template.

We’ll render this view with the arguments `name: "Joel"` and see what it produces.

```phlex
example do |e|
	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def initialize(name:)
				@name = name
			end

			def template
				h1 { "👋 Hello \#{@name}!" }
			end
		end
	RUBY

	e.execute "Hello.new(name: 'Joel').call"
end
```

## Rendering views

Views can render other views in their templates using the `render` method. Let's try rendering a couple of instances of this `Hello` view from a new `Example` view and look at the output of the `Example` view.

```phlex
example do |e|
	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			def template
				render Hello.new(name: "Joel")
				render Hello.new(name: "Alexandre")
			end
		end
	RUBY

	e.tab "hello.rb", <<~RUBY
		class Hello < Phlex::HTML
			def initialize(name:)
				@name = name
			end

			def template
				h1 { "👋 Hello \#{@name}!" }
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```

## Content

Views can also yield content blocks, which can be passed in when rendering. Let's make a `Card` component that yields content in an `<article>` element with a `drop-shadow` class on it.

```phlex
example do |e|
	e.tab "card.rb", <<~RUBY
		class Card < Phlex::HTML
			def template
				article(class: "drop-shadow") do
					yield
				end
			end
		end
	RUBY

	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			def template
				render Card.new do
					h1 { "👋 Hello!" }
				end
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```

The `Example` view renders a `Card` and passes it a block with an `<h1>` tag.

Looking at the output of the `Example` view, we can see the `<h1>` element was rendered inside the `<article>` element from the `Card` view.

## Delegating content

Since the block of content was the only thing we need in the `<article>` element, we could have just passed the content block directly to the element instead.

```ruby
class Card < Phlex::HTML
	def template(&)
		article(class: "drop-shadow", &)
	end
end
```

## Hooks

You can hook into the rendering process by overriding `before_template` and `after_template` which are called immediately before / after the template is rendered.

It’s usually a good idea to call `super` to allow for inherited callbacks.


```phlex
example do |e|
	e.tab "example.rb", <<~RUBY
		class Example < Phlex::HTML
			include Phlex::Callbacks

			def before_template
				h1 { "Hello" }
				super
			end

			def template
				h2 { "World" }
			end

			def after_template
				h3 { "Bye" }
				super
			end
		end
	RUBY

	e.execute "Example.new.call"
end
```
