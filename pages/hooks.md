---
title: Hooks
---

## Hooks & Introspection

You can hook into the rendering process by overriding `before_template`, `after_template` or `around_template`.

You should always call `super` to allow for other inherited callbacks. In the case of `around_template`, calling `super` renders the template, allowing you to execute code *before* and *after* template rendering.

In this example, we define a callback that adds a comment before and after the template is rendered. The comment references the class name, allowing you to see which class was rendered by looking at the output.

```ruby
class Example < Phlex::HTML
	def around_template
		comment { "Begin #{self.class.name}" }
		super
		comment { "End #{self.class.name}" }
	end
end
```
