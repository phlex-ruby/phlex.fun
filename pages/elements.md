---
title: HTML Elements
---

# HTML Elements

`Phlex::HTML` has instance methods that correspond to [HTML elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Element). You can find a complete list below. If we’re missing an element you need, please open an issue.

## Attributes

All element methods accept attributes as keyword arguments:

```ruby
div(class: "foo")
```
```html
<div class="foo"></div>
```

When using `Symbol` keys, underscores are replaced with dashes:

```ruby
div(data_controller: "foo")
```
```html
<div data-controller="foo"></div>
```

When using `String` keys, underscores are not replaced:
```ruby
div("data_controller" => "foo")
```
```html
<div data_controller="foo"></div>
```

`Hash` values are flattened:

```ruby
div(data: { controller: "foo" })
```
```html
<div data-controller="foo"></div>
```

`true` values are omitted:
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

## Custom Elements

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

## Built-in elements

### Void elements

[Void elements](https://developer.mozilla.org/en-US/docs/Glossary/Void_element) can’t contain nested content and they don’t render a closing tag:

```phlex
table do
	Phlex::HTML::VoidElements.registered_elements.each do |method_name, tag|
		tr do
			td { code { method_name } }
			td { a(href: "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/#{tag}") { code { "<#{tag}>" } } }
		end
	end
end
```

### Standard elements

Standard elements accept nested content as a block, and always render with opening and closing tags. Here’s a list of element methods and the coresponding HTML element.

Note that the `<template>` element is created with the `template_tag` method, since `template` defines the template of the component itself.

```phlex
table do
	Phlex::HTML::StandardElements.registered_elements.each do |method_name, tag|
		tr do
			td { code { method_name } }
			td { a(href: "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/#{tag}") { code { "<#{tag}>" } } }
		end
	end
end
```
