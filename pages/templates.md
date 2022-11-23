---
title: Templates in Phlex
---

# Working with templates

In Phlex, templates are just methods that call other methods that add things to the output buffer. When you call the method `h1`, an `<h1>` tag is buffered for output.

## Tag attributes

You can add attributes to HTML tags by passing keyword arguments to the tag methods.

```phlex
example do |e|
  e.tab "hello.rb", <<~RUBY
    class Hello < Phlex::HTML
      def template
        h1(class: "text-xl font-bold") { "👋 Hello World!" }
      end
    end
  RUBY

  e.execute "Hello.new.call"
end
```

## Hash attributes

If you pass a `Hash` as an attribute value, the hash will be flattened with a dash between each section.

```phlex
example do |e|
  e.tab "hello.rb", <<~RUBY
    class Hello < Phlex::HTML
      def template
        div(data: { controller: "hello" }) do
          # ...
        end
      end
    end
  RUBY

  e.execute "Hello.new.call"
end
```

## Boolean attributes

When `true`, the attribute will be rendered without a value; when _falsy_, the attribute isn’t rendered at all. You can still use the strings `"true"` and `"false"` as values for non-boolean attributes.

```phlex
example do |e|
  e.tab "channel_controls.rb", <<~RUBY
    class ChannelControls < Phlex::HTML
      def template
        input(
          value: "1",
          name: "channel",
          type: "radio",
          checked: true
        )

        input(
          value: "2",
          name: "channel",
          type: "radio",
          checked: false
        )
      end
    end
  RUBY

  e.execute "ChannelControls.new.call"
end
```

## The template tag

Because the `template` method is used to define the view template itself, you'll need to use the method `template_tag` if you want to to render an HTML `<template>` tag.

```phlex
example do |e|
  e.tab "example.rb", <<~RUBY
    class Example < Phlex::HTML
      def template
        template_tag do
          img src: "hidden.jpg", alt: "A hidden image."
        end
      end
    end
  RUBY

  e.execute "Example.new.call"
end
```

## Stand-alone text

You can output text content without wrapping it in an element by using the `text` helper method.

```phlex
example do |e|
  e.tab "heading.rb", <<~RUBY
    class Heading < Phlex::HTML
      def template
        h1 do
          strong { "Hello " }
          text "World!"
        end
      end
    end
  RUBY

  e.execute "Heading.new.call"
end
```

## Whitespace

The example output on this site is formatted for readability, but there is usually no whitespace between HTML tags in the output. If you need to add some whitespace, you can use the `whitespace` helper. This is useful for adding space between _inline_ elements to allow them to wrap.

```phlex
example do |e|
  e.tab "links.rb", <<~RUBY
    class Links < Phlex::HTML
      def template
        a(href: "/") { "Home" }
        whitespace
        a(href: "/about") { "About" }
        whitespace
        a(href: "/contact") { "Contact" }
      end
    end
  RUBY

  e.execute "Links.new.call"
end
```
