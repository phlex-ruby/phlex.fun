---
title: Testing Phlex components
---

# Testing

Because Phlex components are just Ruby objects, you can unit-test them like any other Ruby object.

There are so many different libraries and tools for testing HTML. Instead of try to cater for every possible combination, we’re going to serve you a buffet of ideas here and let you build your own.

You’ll want to start by defining a module to load your helpers in. You can then include this module in each of your component tests.

```ruby
module ComponentTestHelper
  # helper methods here
end
```

## Basic `render` helper

One basic helper we could define is a `render` method that takes a component and returns the HTML output. We can use the `call` method for this.

```ruby
def render(component)
  component.call
end
```

With this helper in place, we should be able to write tests like this:

```ruby
output = render Components::Hello.new
assert_equal "<h1>Hello</h1>", output
```

#### Working with Rails <Badge type="danger" text="Rails" />

If you’re testing a Rails app, you’ll probably want to pass in a `view_context` so that your components can use Rails view helpers. The easiest way to do this is to get the `view_context` from a test controller instance and then use that to render the component.

```ruby
def render(...)
  view_context.render(...)
end

def view_context
  controller.view_context
end

def controller
  @controller ||= ActionView::TestCase::TestController.new
end
```

- `render` here delegates to the `render` method on the `view_context`, which is going to use Rails own rendering logic.
- `view_context` is just delegating to `controller`
- `controller` memoizes an `ActionView::TestCase::TestController`

The neat thing about this helper is you can use this same method to render Phlex components and ViewComponent components as well as ERB views and partials.

```ruby
# Phlex
render SomePhlexComponent.new

# ViewComponent
render SomeViewComponent.new

# ERB Partial
render "some_partial"

# ERB View
render template: "some_view_template", layout: "some_layout"
```

## Parsing with Nokogiri

Now we can render components to HTML with the `render` helper, let’s look at making assertions against it. You can use `assert_equal` on the HTML output for small, predictable things but it’ll only get you so far.

Ideally, we need a way to query the HTML — to check if it contains specific CSS or XPath selectors. To do that, we’re going to need to parse it.

Nokogiri is an HTML parser that you can install as a Ruby gem. If you’re using Rails, there’s a good chance it’s already installed in your app. You can require it with `require "nokogiri"`.

When parsing HTML with Nokogiri, you need to decide if you’re parsing it as an entire HTML document or just as a fragment of a document.

HTML documents must have things like a `<html>`, `<head>` and `<body>` tags. If they’re missing, Nokogiri will insert them just like a browser would. If you’re just testing a small fragment of HTML that isn’t meant to represent an entire document, you should parse it as a fragment.

We’ll use the `render` method from before with Nokogiri to create `render_document` and `render_fragment` methods.

```ruby
def render_fragment(...)
  html = render(...)
  Nokogiri::HTML5.fragment(html)
end

def render_document(...)
  html = render(...)
  Nokogiri::HTML5(html)
end
```

These methods now return the parsed HTML as a _tree_ that you can query to build more advanced assertions.
