---
title: Component UI Kits in Phlex
---

# Kits

In the previous sections, we looked at how to render components and yield interfaces. Kits add some Ruby magic to make this even cleaner.

A Kit is a special Ruby module that you put components in. You can create a Kit by defining a module that extends `Phlex::Kit`.

```ruby
module Components
  extend Phlex::Kit
end
```

That’s it. Now the `Components` module is a Kit. And every module defined in its namespace is also a Kit.

When you define a component in a Kit namespace, Phlex gives you a new, cleaner way to render those components.

Let’s define a card component in the `Components` kit:

```ruby
class Components::Card < Phlex::HTML
  def initialize(title)
    @title = title
  end

  def view_template
    article(class: "card") do
      h2(class: "card-title") { @title }
      yield
    end
  end
end
```

Now we have a special way to render this component from another component.

```ruby
class Example < Phlex::HTML
  def view_template
    Components::Card("Hello, World!") do
      p { "This is a card." }
    end
  end
end
```

The kit detected the definition of a component and defined a special method on the kit with the same name (`Card`). Calling this method means we don’t need to use `render` or `.new`.

You can think of it like the kit has defined this:

```ruby
module Components
  def Card(...)
    render Card.new(...)
  end
end
```

Additionally, you can include the Kit to make all of its components available without the namespace.

```ruby
class Example < Phlex::HTML
  include Components

  def view_template
    Card("Hello, World!") do
      p { "This is a card." }
    end
  end
end
```

The `phlex-rails` install generator automatically defines a `Components` kit and includes it in the base component.

These methods always start with a capital letter so they match the constant name of the component class and to distinguish them from HTML elements. e.g. the `article` method is for the `<article>` element, but you can have an `Article` method for your `Article` component.

Ruby needs to be able to distinguish between a method call and a constant lookup. This is determined when you pass a block or arguments. To render a component without a block or other arguments, you need to use empty parentheses.

```ruby
Header()
```

It’s up to you whether you use Kits or not. They may feel _too magical_. Capital-letter methods are rare in Ruby. I personally prefer the aesthetic, but it’s your choice.

Here’s what our `Table` component from the previous section would look like using Kits.

:::code-group

```ruby [With Kits]
Table(@people) do |t|
  t.column("Name", &:name)
  t.column("Age", &:age)
end
```

```ruby [Without Kits]
render Table.new(@people) do |t|
  t.column("Name", &:name)
  t.column("Age", &:age)
end
```

:::

It is not possible to use this simplified syntax from ERB, even if the component is in a Kit. Kits only work from a Phlex context.
