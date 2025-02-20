---
title: Rendering Phlex Components
---

# Rendering

Since Phlex components are just Ruby classes, you can create a component by calling `new` on your component class and passing in your properties.

```ruby
class MyComponent < Phlex::HTML
  def initialize(name:)
    @name = name
  end

  def view_template
    h1 { "Hello, #{@name}" }
  end
end
```

```ruby
component = MyComponent.new(name: "World")
```

::: tip
If you pass a block to `new` here, your `initialize` method will not receive it. Instead, the `view_template` will be called with that block when the component is rendered. This means your component can handle blocks that were passed in at initialization and blocks that were passed in at render in the same way.
:::

## Rendering a component from the outside

You can render a Phlex component by calling its `call` method. This interface is usually handled by framework-level integrations.

```ruby
component = MyComponent.new(name: "World")

html_output = component.call
```

You can optionally pass in a custom buffer object, which will be mutated and returned by `call`. Your buffer needs to respond to `<<` returning `self`. By default, Phlex uses a mutable string as its buffer but you could use a different object such as an `Array` or an `Enumerator::Yielder`.

While rendering, Phlex writes to an internal buffer, but `flush` will copy the internal buffer and write it to the output buffer. This is only relevant when streaming the output buffer.

You could create an abstraction that calls `flush` while waiting on IO, for example.

## Rendering from a Rails controller <Badge type="danger" text="Rails" />

Typically, you won’t call the `call` method yourself. In Rails, you can render a Phlex component from a controller with the `render` method.

```ruby
def index
  render Views::Articles::Index.new(
    articles: Article.all
  )
end
```

Using the `render` method on the controller allows Rails to pass in a view context, which provides access to the Rails helpers via adapters.

## Rendering from another component

You can render a Phlex component from another component with the `render` instance method. Here, we’ll render the `Components::Article` component for each article passed into the `Views::Articles::Index` component.

```ruby{8}
class Views::Articles::Index < Phlex::HTML
  def initialize(articles:)
    @articles = articles
  end

  def view_template
    @articles.each do |article|
      render Components::Article.new(article:)
    end
  end
end
```

If the component does not take any properties, you can omit the `.new` and render the component class directly. Phlex will automatically initialize an instance by calling `new` without any arguments.

```ruby{7}
class Views::Articles::Index < Phlex::HTML
  def initialize(articles:)
    @articles = articles
  end

  def view_template
    render Components::Sidebar

    @articles.each do |article|
      render Components::Article.new(article:)
    end
  end
end
```

## Nesting components

You can pass a content block to a component when rendering. The block will be rendered when the component yields the content.

```ruby{7-9}
class Components::Article < Phlex::HTML
  def initialize(article:)
    @article = article
  end

  def view_template
    render Components::Card do
      h1 { @article.title }
    end
  end
end
```

In this example, because the Card component _yields_, the context in the block (`self`) is the instance of the Article component. That’s why the `@articles` instance variable is available in this block, even though it wasn’t passed down to the Card component.

## Rendering Phlex components in ERB <Badge type="danger" text="Rails" />

You can also render Phlex components from ERB and other Rails templating languages, such as [Slim](https://slim-template.github.io) and [Haml](https://haml.info). This works from views, partials or even [ViewComponent](https://viewcomponent.org) components.

```erb
<%= render Card.new(title: "Hello") do %>
  <h1>Inside Bar</h1>
<% end %>
```

When rendering from ERB, the block given to the component is expected to return an HTML safe string (an `ActiveSupport::SafeBuffer`). This happens automatically from ERB and Phlex confirms this as part of the integration.

## Rendering Rails partials in Phlex <Badge type="danger" text="Rails" />

To render your existing Rails partials in Phlex, you need to use `render` and `partial` together. `partial` takes the partial name and parameters and returns a renderable object.

```ruby{7-9}
class Components::Article < Phlex::HTML
  def initialize(article:)
    @article = article
  end

  def view_template
    render partial("card", title: "Hello") do
      h1 { @article.title }
    end
  end
end
```

The `partial` method is necessary because `render` will render plain strings as plain text.

## Rendering ViewComponent components in Phlex <Badge type="danger" text="Rails" />

You can render ViewComponent components in much the same way that you’d render Phlex components.

```ruby{7-9}
class Components::Article < Phlex::HTML
  def initialize(article:)
    @article = article
  end

  def view_template
    render CardComponent.new(title: "Hello") do
      h1 { @article.title }
    end
  end
end
```

## Other renderables

The `render` method in Phlex is designed for maximal polymorphism. You should be able to create a component that takes a renderable as a property and then renders it in the template.

```ruby
class Example < Phlex::HTML
  def initialize(renderable:)
    @renderable = renderable
  end

  def view_template
    render @renderable
  end
end
```

The polymorphism of `render` here means this _renderable_ property could be any of the following:

| Type                           | Description                                           |
| ------------------------------ | ----------------------------------------------------- |
| `Phlex::HTML`                  | Renders the HTML component.                           |
| `Phlex::SVG`                   | Renders the SVG component.                            |
| `String`                       | Renders the value as plain text.                      |
| `Proc`                         | Yields the proc.                                      |
| `Method`                       | Yields the method.                                    |
| `nil`                          | No-op (and no error)                                  |
| `Class(Phlex::HTML)`           | Creates a new instance of the class and renders that. |
| `Class(Phlex::SVG)`            | Creates a new instance of the class and renders that. |
| `Enumerable` (such as `Array`) | Iterates by calling `each` and renders each item.     |
| Anything else                  | Raises a `Phlex::ArgumentError`                       |

### Other renderables in Rails <Badge type="danger" text="Rails" />

In Rails, ViewComponent components are also accepted as renderables and they are handled in a way that adapts Phlex for the slots.

In the else condition, instead of raising a `Phlex::ArgumentError`, Phlex delegates to Rails’ own `render` method.

The inputs and outputs are adapted. For example, Rails expects renderable blocks to return an HTML safe string (an `ActiveSupport::SafeBuffer`) so Phlex automatically wraps your block in a `capture` before passing it down.
