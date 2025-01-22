---
prev: false
---

# Intro

Phlex is a Ruby gem for building object-oriented views directly in Ruby. It supports **HTML**, **SVG** and **CSV** views, but we’ll mostly focus on HTML views in this guide.

Phlex components are Ruby classes that describe discrete parts of your view. You might have a component for your _layout_, _header_, _footer_ as well as abstract parts like _buttons_, _tables_, _form inputs_.

Each component is defined as a Ruby class with a `view_template` method.

Let’s start by looking at a small example: here we have a `Nav` component with a `view_template` that renders a `<nav>` element with the class `main-nav`.

Inside that element is a `<ul>` element that _yields_ the that’s passed in when rendering the component.

Next, we define the public method `item` to take an `href` and render a link `<a>` wrapped in a list item `<li>`. Again, we yield for the content.

```ruby
class Components::Nav < Phlex::HTML
  def view_template
    nav(class: "main-nav") {
      ul { yield }
    }
  end

  def item(href)
    li(class: "nav-item") {
      a(href:, class: "nav-link") { yield }
    }
  end
end
```

Now we can use this `Nav` component to render our nav in a `Header` component:

```ruby
class Components::Header < Phlex::HTML
  def view_template
    Nav do |nav|
      nav.item("/") { "Home "}
      nav.item("/about") { "About" }
      nav.item("/contact") { "Contact" }
    end
  end
end
```

Notice how we can call the method `Nav` to render the component called `Nav` and it yields the instance of the component, allowing us to call `item` many times in the block.

Each time we call `item`, a new item is rendered. And at the end of the block, the `<ul>` and `<nav>` elements are automatically closed.
