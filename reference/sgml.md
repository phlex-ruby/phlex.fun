# `Phlex::SGML`

`Phlex::SGML` (which stands for [Standard Generalized Markup Language](https://en.wikipedia.org/wiki/Standard_Generalized_Markup_Language)) is the superclass of `Phlex::HTML` and `Phlex::SVG`. It provides a common interface for both HTML and SVG components.

You can use this interface by subclassing either `Phlex::HTML` or `Phlex::SVG` with your own component class.

## Class methods

### `.new`

It’s worth noting that `Phlex::SGML` overrides `.new` in order to capture the block during instantiation. This block will not be passed on to your `#initialize` method. Instead, it is passed to your `#view_template` method when the component is rendered.

### `.register_element`

Allows you to define a custom element that can be used in your templates. Since this defines an instance method, it’s inherited by subclasses.

```ruby{2,5}
class MyComponent < Phlex::HTML
  register_element :trix_editor

  def view_template
    trix_editor
  end
end
```

## Instance methods

### `#after_template`

### `#around_template`

### `#await`

### `#before_template`

### `#call`

### `#capture`

### `#comment`

### `#comment`

### `#context`

### `#flush`

### `#format_object`

### `#plain`

### `#render?`

### `#render`

### `#tag`

### `#unsafe_raw`

### `#unsafe_tag`

### `#vanish`

### `#whitespace`
