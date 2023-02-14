---
title: Components
---

# Components

You can build reusable & composable Phlex views.

For example, you may need to define multiple sections (slots) in a view. This can be accomplished by defining public instance methods on the view that accept blocks:

```phlex
example do |e|
  e.tab "card.rb", <<~RUBY
    class Card < Phlex::HTML
      def template(&)
        article(class: "card", &)
      end

      def title(&)
        div(class: "title", &)
      end

      def body(&)
        div(class: "body", &)
      end
    end
  RUBY

  e.tab "example.rb", <<~RUBY
    class Example < Phlex::HTML
      def template
        render Card.new do |card|
          card.title do
            h1 { "Title" }
          end

          card.body do
            p { "Body" }
          end
        end
      end
    end
  RUBY

  e.execute "Example.new.call"
end
```

This would work just fine for a list of views as each method can be called multiple times.

One caveat of defining the view this way is `title` and `body` could be called in any order. This offers flexibility, but what if you need to make sure your markup is output in a consistent order?

First, include `Phlex::DeferredRender` in your view. This changes the behavior of `template` so it does not receive a block and is yielded early. Then use public methods to save blocks, passing them to back to the `template` at render time.

```phlex
example do |e|
  e.tab "list.rb", <<~RUBY
    class List < Phlex::HTML
      include Phlex::DeferredRender

      def initialize
        @items = []
      end

      def template
        if @header
          h1(class: "header", &@header)
        end

        ul do
          @items.each do |item|
            render(item)
          end
        end
      end

      def header(&block)
        @header = block
      end

      def with_item(...)
        @items << Item.new(...)
      end
    end
  RUBY

  e.tab "item.rb", <<~RUBY
    class Item < Phlex::HTML
      def template(&)
        li(&)
      end
    end
  RUBY

  e.tab "example.rb", <<~RUBY
    class Example < Phlex::HTML
      def template
        render List.new do |list|
          list.header do
            "Header"
          end

          list.with_item do
            "One"
          end

          list.with_item do
            "two"
          end
        end
      end
    end
  RUBY

  e.execute "Example.new.call"
end
```


