---
title: Phlex — fast, object-oriented view framework for Ruby
---

# Introduction
Phlex is a framework for building fast, reusable, testable views in pure Ruby.

```phlex
example do |e|
  e.tab "nav.rb", <<~RUBY
    class Nav < Phlex::HTML
      def template
        nav(class: "main-nav") {
          ul {
            li { a(href: "/") { "Home" } }
            li { a(href: "/about") { "About" } }
            li { a(href: "/contact") { "Contact" } }
          }
        }
      end
    end
  RUBY

  e.execute "Nav.new.call"
end
```

## Better developer experience 💃
Phlex views are “plain old Ruby objects” — templates are methods and HTML tags are method calls. If you know how to define a class with a method that calls another method, you know how to use Phlex.

## Better safety 🥽

Phlex view templates render in an isolated execution context where only the instance variables and methods for the specific view are exposed.

## Better performance 🔥

Rendering a Phlex view is significantly faster than rendering an ActionView partial or ViewComponent component.


# What’s a view?

Views are Ruby objects that represent a piece of output from your app. We plan to support various different types of output — such as JSON, XML and SVG — but for now, we’re focusing on HTML.

Views can have an `initialize` method that dictates which arguments the view accepts and is responsible for setting everything up — usually assigning instance variables for use in the *template*.

The *template* is a special method that’s called when rendering a view. The `template` method determines the output of the view by calling methods that append to the output.

Instance methods perform important calculations or encapsulate a small part of the template. Public instance methods can expose an interface that’s yielded to the parent when rendering.
