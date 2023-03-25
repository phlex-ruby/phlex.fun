---
title: Layouts in Rails
---

# Layouts in Rails

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

## Yielding content

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
