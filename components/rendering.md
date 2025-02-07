# Rendering

## Rendering a component from the outside

You can render a Phlex component by calling its `call` method. This interface is usually handled by framework-level integrations.

```ruby
component = MyComponent.new

html_output = component.call
```

You can optionally pass in a custom buffer object, which will be mutated and returned. Your buffer needs to respond to `<<` returning `self`. By default, Phlex uses a mutable string as its buffer.

Mostly Phlex writes to an internal buffer, but `flush` will flush the internal buffer to the output buffer. This is only relevant when streaming the output buffer.

## Rendering from a Rails controller <Badge type="tip" text="Rails" />

In Rails, you can render a Phlex component from a controller with `render` method.

```ruby
def index
  render Views::Articles::Index.new(
    articles: Article.all
  )
end
```

One advantage here is that the Index view requires we give it a list of articles. It doesn’t implicitly depend on an instance variable being set in the controller.

## Rendering from another component

You can render a Phlex component from another component with the `render` method.

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

If the component does not take any properties, you can omit the `.new` and render the component class directly. Phlex will automatically initialize an instance by calling `.new` without any arguments.

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

## Rendering Phlex components in ERB <Badge type="tip" text="Rails" />

You can also render Phlex components from ERB and other Rails templating languages such as Slim and HAML. This works from views, partials or even ViewComponent components.

```erb
<%= render Card.new(title: "Hello") do %>
  <h1>Inside Bar</h1>
<% end %>
```

When rendering from ERB, the block given to the component is expected to return an HTML safe string (an `ActiveSupport::SafeBuffer`). This happens automatically from ERB. The point is, you can’t use Phlex’ DSL from an ERB context.

## Rendering Rails partials in Phlex <Badge type="tip" text="Rails" />

To render your existing Rails partials in Phlex, you need to use `render` in conjunction with `partial`.

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

The `partial` method is necessary because `render` will render plain strings as text. `partial` returns a `Phlex::Rails::Partial` object that references the partial. This object can be passed to other components for rendering.

It is also a Rails _renderable_ so if you passed it into an ERB partial as a local, the partial could render it with Rails’ `render` method.

## Rendering ViewComponent components in Phlex <Badge type="tip" text="Rails" />

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
