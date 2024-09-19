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

A hook that is called after the template is rendered. Can be overridden to add custom behavior.

### `#around_template`

A hook that wraps the template rendering. Can be overridden to add custom behavior before and after rendering. You should always call `super` in your implementation.

```ruby
def around_template
  puts "Before rendering"
  super
  puts "After rendering"
end
```

### `#await`

Waits for an asynchronous task to complete. If the task isn’t completed, it flushes. Supports `Concurrent::IVar` and `Async::Task`.

### `#before_template`

A hook that is called before the template is rendered. Can be overridden to add custom behavior.

### `#call`

Renders the view and returns the buffer. The default buffer is a mutable String.

### `#capture`

Captures the block and returns the output as a string. In Rails, this is an `ActionView::SafeBuffer`.

### `#comment`

Outputs an HTML comment. You can wrap other content and the content will still be rendered.

### `#context`

Returns the current render context data.

### `#flush`

Flushes the buffer if not capturing.

### `#format_object`

Formats an object for output. Can be overridden to handle different object types.

### `#plain`

Outputs text content. The text will be HTML-escaped.

### `#render?`

Determines if the component should render. By default, it returns `true`. Override this method to conditionally render the component.

### `#render`

Renders another component, block, string, or enumerable of the above.

### `#vanish`

Similar to `#capture`, but the output is discarded.

### `#whitespace`

Outputs a whitespace character. Useful for getting inline elements to wrap. You can optionall pass a block to wrap the content with a whitespace character on before and after.

### `#view_template`

The main template method that should be overridden in subclasses to define the component’s structure.
