# Under the hood

You’ve successfully installed Phlex and rendered your first component. Now let’s take a moment to understand what’s happening behind the scenes. To do this, we’re going to build a miniature version of Phlex from scratch.

It won’t have advanced features, performance optimizations or HTML safety, but I think it’ll give you a good sense of things.

## Buffers and hierarchy

We’ll start by creating a `Component` class with a `@buffer` instance variable. Phlex uses a mutable String for its buffer, but we’ll use an Array since it’s easier to debug.

```ruby
class Component
  def initialize
    @buffer = []
  end
end
```

Now we want to be able to render HTML tags. Let’s start with `<div>` and we can add a few more later.

```ruby
def div
  @buffer << "<div>"
  yield if block_given?
  @buffer << "</div>"
end
```

Our `div` method first pushes an opening `<div>` tag onto the buffer, then yields itself to the block if a block is given. Finally, it pushes a closing `</div>` tag onto the buffer.

Let’s add one more method so we can render our components to a string.

```ruby
def call
  view_template
  @buffer.join
end
```

This method, `call`, first calls the `view_template` method (which we haven’t defined yet) then it joins the buffer into a single string and returns it.

The whole class should look like this:

```ruby
class Component
  def initialize
    @buffer = []
  end

  def call
    view_template
    @buffer.join
  end

  def div
    @buffer << "<div>"
    yield if block_given?
    @buffer << "</div>"
  end
end
```

Now we’re ready to create a component. Let’s make a simple `HelloWorld` component — though we’re not quite ready to say `"Hello World"` just yet. Instead, we’ll render a couple of nested divs.

```ruby
class HelloWorld < Component
  def view_template
    div {
      div
    }
  end
end
```

This `HelloWorld` component inherits from our abstract `Component` class and implements the `view_template` method that we called from the `call` method before.

Let’s see what it looks like when we `call` our `HelloWorld` component to render it:

```ruby
puts HelloWorld.new.call
```

You should see the following output with one div nested inside another:

```html
<div><div></div></div>
```

Ruby handled the hierarchy for us. We got part way into the first div when we _yielded_ to the block which started a new div. Since there was no block given to this inner div, it closed immediately yielding control back to the original outer div, which then closed.

## Handling text content

Let’s add the ability to render text content inside our divs. We’ll update the method to accept an optional `content` argument. If `content` is provided, we’ll push it onto the buffer. Otherwise, we’ll yield to the block as before if a block is given.

```ruby
def div(content = nil)
  @buffer << "<div>"

  if content
    @buffer << content
  elsif block_given?
    yield
  end

  @buffer << "</div>"
end
```

::: warning
This implementation doesn’t handle HTML safety. In a real-world scenario, you’d want to escape any HTML content to prevent cross-site-scripting attacks, where a user could inject malicious code into your page by providing it as their name, for example.
:::

Let’s go back to our `HelloWorld` component and add some text content to the inner div.

```ruby
class HelloWorld < Component
  def view_template
    div {
      div("Hello, World!")
    }
  end
end
```

Now when we render our `HelloWorld` component, we should see the following output:

```html
<div><div>Hello, World!</div></div>
```

## Handling attributes

Let’s add the ability to render attributes on our divs. We’ll update the method to accept an optional `attributes` hash. We can do this by accepting a double splat argument, `**attributes`, which will collect all the keyword arguments into a new `Hash`.

Now we want to start by pushing just the opening `<div` onto the buffer. Then we’ll iterate over the `attributes` hash and push each key-value pair onto the buffer. Finally, we’ll push the closing `>` onto the buffer and continue as before.

```ruby{2-8}
def div(content = nil, **attributes)
  @buffer << "<div"

  attributes.each do |key, value|
    @buffer << " #{key}=\"#{value}\""
  end

  @buffer << ">"

  if content
    @buffer << content
  elsif block_given?
    yield
  end

  @buffer << "</div>"
end
```

Let’s go back to our `HelloWorld` component and add a class attribute to each of the divs.

```ruby{3-4}
class HelloWorld < Component
  def view_template
    div(class: "outer") {
      div("Hello, World!", class: "inner")
    }
  end
end
```

Now when we render our `HelloWorld` component, we should see the following output:

```html
<div class="outer"><div class="inner">Hello, World!</div></div>
```

## Nesting components

For the final step, let’s add the ability to nest components inside one another.

To do this we’ll need the ability to pass a buffer to a component when we come to rendering it. Let’s remove the original `initialize` method and update the `call` method to accept a buffer argument instead.

We’ll also accept a block (`&`) and pass it to the `view_template` method.

```ruby
def call(buffer = [], &)
  @buffer = buffer
  view_template(&)
  @buffer.join
end
```

The buffer still defaults to an empty array, but now we can pass in a buffer from the outside. The block allows us to yield content in our template.

Let’s define a `render` method that takes a component and renders, passing the buffer and the block.

```ruby
def render(component, &)
  component.call(@buffer, &)
end
```

The whole `Component` class should now look like this:

```ruby
class Component
  def call(buffer = [], &)
    @buffer = buffer
    view_template(&)
    @buffer.join
  end

  def div(content = nil, **attributes)
    @buffer << "<div"

    attributes.each do |key, value|
      @buffer << " #{key}=\"#{value}\""
    end

    @buffer << ">"

    if content
      @buffer << content
    elsif block_given?
      yield
    end

    @buffer << "</div>"
  end

  def render(component, &)
    component.call(@buffer, &)
  end
end
```

Now let’s create a new component called `Card`:

```ruby
class Card < Component
  def view_template(&)
    div(class: "card", &)
  end
end
```

Back in our `HelloWorld` component, let’s update it to render our `Card` component:

```ruby
class HelloWorld < Component
  def view_template
    div(class: "outer") {
      render Card.new do
        div("Hello, World!", class: "inner")
      end
    }
  end
end
```

The output should now be something like this (without newlines and indentation):

```html
<div class="outer">
  <div class="card">
    <div class="inner">Hello, World!</div>
  </div>
</div>
```

## Plain text

In about 30 lines of code, we’ve build a simple component abstraction for rendering HTML. We can render nested divs with content and attributes and we can nest components inside one another.

However, what we can’t do is render text without wrapping it in a div. Let’s fix that with a new method called `plain` that simply pushes content onto the buffer.

```ruby
def plain(content)
  @buffer << content
end
```

Now we can update our `HelloWorld` component to render the text directly inside the `Card` component:

```ruby
class HelloWorld < Component
  def view_template
    div(class: "outer") {
      render Card.new do
        plain "Hello, World!"
      end
    }
  end
end
```

## Supporting advanced DSLs

What if we want to our Card component to expose an interface for interacting with it. For example, we might want to set the title.

Let’s start by updating the Card component as if this worked and then we’ll get it working.

```ruby
class Card < Component
  def view_template(&)
    div(class: "card", &)
  end

  def title(content)
    div(content, class: "card-title")
  end
end
```

This `title` method perfectly encapsulates the card title. But how can we call it at just the right moment so that it pushes to the buffer in the right place?

The trick here is to yield the component to the block that’s passed to `view_template` from the `render` method. This will allow us to pick up the card component when passing in the block.

```ruby
class HelloWorld < Component
  def view_template
    div(class: "outer") {
      render Card.new do |card|
        card.title "Hello, World!"
      end
    }
  end
end
```

To get this to work, we’ll need to find the point where we yield and make it `yield(self)`. We could do this in the `div` method, but there’s a better way.

When the block comes into `call`, we can wrap it in a new block that yields `self`. This way, it will always yield the component instance even if we forget to.

```ruby
def call(buffer = [])
  @buffer = buffer
  view_template { yield(self) if block_given? }
  @buffer.join
end
```

This is a little mind-bending. We’re now always passing a block to `view_template`, that yields self to the block that was passed to `call` if a block was passed.

The final `Component` class should look like this — just 33 lines of Ruby:

```ruby
class Component
  def call(buffer = [])
    @buffer = buffer
    view_template { yield(self) if block_given? }
    @buffer.join
  end

  def div(content = nil, **attributes)
    @buffer << "<div"

    attributes.each do |key, value|
      @buffer << " #{key}=\"#{value}\""
    end

    @buffer << ">"

    if content
      @buffer << content
    elsif block_given?
      yield
    end

    @buffer << "</div>"
  end

  def plain(content)
    @buffer << content
  end

  def render(component, &)
    component.call(@buffer, &)
  end
end
```

Our `HelloWorld` component with the `card.title` interface should now render the title correctly:

```html
<div class="outer">
  <div class="card">
    <div class="card-title">Hello, World!</div>
  </div>
</div>
```
