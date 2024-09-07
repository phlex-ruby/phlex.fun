---
prev: false
---

# Intro

Phlex is a Ruby gem for building fast object-oriented views. Phlex actually supports **HTML**, **SVG** and **CSV** views, but we'll focus on HTML views to begin with.

Phlex views are composed of components. Components can be concrete, like a **Header** or **Footer**, or more abstract like a **Button**. They can be nested in other components or wrap a layout around your content.

Templates are described using basic Ruby constructs: _methods_, _arguments_ and _blocks_, which directly correspond to HTML _tags_, _attributes_ and _content_.

Building components in Ruby makes it possible to build powerful abstractions. For example, let’s build a `Nav` component that allows developers to add items to the menu without needing to understand the underlying HTML.

```ruby
class Nav < Phlex::HTML
  def view_template(&)
    nav(class: "main-nav") { ul(&) }
  end

  def item(text, href)
    li(class: "nav-item") {
      a(href:, class: "nav-link") { text }
    }
  end
end
```

Now we can use this `Nav` component to build out our menu in our `Header` component:

```ruby{3-7}
class Header < Phlex::HTML
  def view_template
    render Nav.new do |nav|
      nav.item("/") { "Home "}
      nav.item("/about") { "About" }
      nav.item("/contact") { "Contact" }
    end
  end
end
```

Now the details of how to render a navigation menu are encapsulated in the `Nav` class, and the `Header` component can focus on the high-level structure.
