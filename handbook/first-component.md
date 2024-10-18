# Building your first component in Phlex

Let’s start by building a simple Card component. A Card is a presentational component, it doesn’t
really have any behavior. So it’s going to be mostly for abstracting away the CSS classes and specific
markup. We’ll use simple classes in our example, but you could imagine if you were using a utility
based CSS framework like Tailwind that you would be abstracting away a lot more.

```ruby
# app/components/card.rb
class Components::Card < Phlex::HTML
  def view_template(&)
    div(class: "card", &)
  end
end
```

Not the most exciting component, but it’s a start. We can use it like this:

::: code-group

```ruby [view.rb]
class View < Phlex::HTML
  def view_template
    render Card.new do
      p { "Card content" }
    end
  end
end
```

```html [output]
<div class="card">
  <p>Card content</p>
</div>
```

:::

This is nice, but some of our cards will need a header section that has a title. Let’s keep adding
to our `Card` component so that it can have an optional header:

```ruby
class Card < Phlex::HTML
  def view_template(&)
    div(class: "card", &)
  end

  def header(&) # [!code ++:3]
    div(class: "card-header", &)
  end

  def title(&) # [!code ++:3]
    h2(class: "card-title", &)
  end
end
```

We’ve added `header` and `title` methods to our `Card` component. Now when we render a card, we can
use the block argument, which will be the instance of our `Card`, and call our new methods:

::: code-group

```ruby [view.rb]
class View < Phlex::HTML
  def view_template
    render Card.new do # [!code --]
    render Card.new do |c| # [!code ++:4]
      c.header do
        c.title { "Card Title" }
      end
      p { "Card content" }
    end
  end
end
```

```html [output]
<div class="card">
  <div class="card-header">
    <h2 class="card-title">Card Title</h2>
  </div>
  <p>Card content</p>
</div>
```

:::

Ok, this is starting to look a bit better. But we also need a way to add an action button to our card.
This will need a bit more flexibility than just changing the content of the button. Let’s see what
that looks like:

```ruby
class Card < Phlex::HTML
  def view_template(&)
    div(class: "card", &)
  end

  def header(&)
    div(class: "card-header", &)
  end

  def title(&)
    h2(class: "card-title", &)
  end

  def action(**, &) # [!code ++:3]
    a(class: "card-action", **, &)
  end
end
```

This will let us pass in attributes to the action button.

::: code-group

```ruby [view.rb]
class View < Phlex::HTML
  def view_template
    render Card.new do |c|
      c.header do
        c.title { "Card Title" }
      end
      p { "Card content" }
      c.action(href: "/") { "Action" }
    end
  end
end
```

```html [output]
<div class="card">
  <div class="card-header">
    <h2 class="card-title">Card Title</h2>
  </div>
  <p>Card content</p>
  <a class="card-action" href="/">Action</a>
</div>
```

:::

This seems like it’s working, but we actually have a bit of a problem. We can’t specify a class for
our action button without overriding the class provided in the `action` method. Any custom class or
classes we provide will clobber the default `card-action` class. Phlex provides a helper method to help
us deal with this situation called `mix`. It mixes attributes together, and is aware of token lists.
Let’s update our `action` method to use `mix`:

```ruby
def action(**attributes, &)
  a(**mix(attributes, class: "card-action"), &)
end
```

Now if we specify a custom class when we call our `action` method, it will be added to the class list
instead of overriding it.

::: code-group

```ruby [view.rb]
class View < Phlex::HTML
  def view_template
    render Card.new do |c|
      c.header do
        c.title { "Card Title" }
        c.action(class: "custom-class") { "Action" }
      end
      p { "Card content" }
    end
  end
end
```

```html [output]
<div class="card">
  <div class="card-header">
    <h2 class="card-title">Card Title</h2>
    <a class="card-action custom-class" href="/">Action</a>
  </div>
  <p>Card content</p>
</div>
```

:::
