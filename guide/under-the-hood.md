# Under the hood

You’ve successfully installed Phlex and rendered your first component. Now let’s take a moment to understand what’s happening behind the scenes. To do this, we’re going to build a mineature version of Phlex from scratch.

It won’t have advanced features, performance optimizations or HTML safety, but I think it’ll give you a good sense of things.

## Buffers and hirearchy

We’ll start by creating a `Component` class with a `@buffer` instance variable. Phlex uses a mutible String for its buffer, but we’ll use an Array since it’s easier to debug.

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
  yield(self) if block_given?
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
