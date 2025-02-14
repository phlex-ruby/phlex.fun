# Yielding

In previous section, we learned how to render components and pass in a block of content. In this section will look at how to yield that block of content.

We’ll also explore how you can yield an interface that allows the outer component to use behaviours defined on your inner component.

## Yielding content

When your component is rendered with a block of content, that block is received by the `view_template` method. Actually, the content block is wrapped in another block first, but you don’t need to think about that for the most part.

Blocks are wrapped so that `yield` automatically becomes `yield(self)` and so that blocks returning a value instead of producing HTML are treated as plain text.

Let’s create a component that yields content.

```ruby{9}
class Card < Phlex::HTML
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

When you call this component with a content block, it will be output at the yield.

```ruby
render Card.new("Hello") do
  p "Hello, World"
end
```

Because HTML element methods yield their blocks, you can pass a content block received in a `view_template` down to an HTML element rather than yielding it yourself.

```ruby{6,9}
class Card < Phlex::HTML
  def initialize(title)
    @title = title
  end

  def view_template(&content)
    article(class: "card") do
      h2(class: "card-title") { @title }
      div(class: "card-content", &content)
    end
  end
end
```

## Yielding an interface

I mentioned earlier that `yield` is automatically upgraded to `yield(self)`. This makes it convenient to yield a specialized interface that the parent component can use. Let’s say we want an abstract `Nav` component that allows you to add nav items.

One way to do this is to serialize the nav items as data.

```ruby
render Nav.new(
  ["Home", "/"],
  ["About", "/about"],
  ["Contact", "/contact"]
)
```

This technique is fine, but it’s quite brittle. What if we wanted to wrap `"Home"` in a `<strong>` tag? What if we wanted to have a divider between `"About"` and `"Contact"`? It would be quite tricky to model this in our array of nav items.

Another approach is to define two additional components `NavItem` and `NavDivider`.

```ruby
render Nav do
  render NavItem.new("/") { strong { "Home" } }
  render NavItem.new("/about") { "About" }
  render NavDivider
  render NavItem.new("/contact") { "Contact" }
end
```

But defining components for these parts doesn’t necessarily make sense. You have no reason to render a nav item or nav divider outside a nav and who wants to make a whole class for a nav divider.

Ideally, the Nav component would itself provide an interface for rendering items and dividers. An ideal interface might look something like this:

```ruby
render Nav do |nav|
  nav.item("/") { strong { "Home" } }
  nav.item("/about") { "About" }
  nav.divider
  nav.item("/contact") { "Contact" }
end
```

So here we pass a content block to `Nav` and then pick up its yield, naming it `nav`. Remember how components `yield(self)` by default? `nav` here points to the instance of the `Nav` component that we’re currently rendering.

That means this `nav.item` and `nav.divider` interface can be implemented by defining public `item` and `divider` instance methods on the `Nav` class.

Here’s what that might look like:

```ruby
class Nav < Phlex::HTML
  def view_template(&)
    nav(class: "special-nav", &)
  end

  def item(href, &)
    a(class: "special-nav-item", href:, &)
  end

  def divider
    span(class: "special-nav-divider")
  end
end
```

## Vanishing the yield

In the previous example, we were able yield an interface which the parent component used to compose a nav. Within the block, each time we called `item` or `divider`, the HTML defined in that method was immediately pushed to the buffer.

This is an incredibly flexible technique, but there are some scenarios that benefit from an alternative approach.

Let’s think about what this might look like if we were to build a table component.

```ruby
render Table do |t|
  t.head do
    t.row do
      t.header { "Name" }
      t.header { "Age" }
    end
  end

  t.body do
    @people.each do |person|
      t.row do
        t.cell { person.name }
        t.cell { person.age }
      end
    end
  end
end
```

This has some advantage over raw HTML, because we can define each of these methods: `head`, `body`, `row`, `header`, `cell` and they can produce whatever HTML we want with all the right Tailwind classes, etc.

What if our interface was built around columns instead and it automatically figured out headers and rows? The ideal interface might look something like this.

```ruby
render Table.new(@people) do |t|
  t.column("Name") { |person| person.name }
  t.column("Age") { |person| person.age }
end
```

In fact, we could use Ruby’s `Symbol#to_proc` to make this even more concise.

```ruby
render Table.new(@people) do |t|
  t.column("Name", &:name)
  t.column("Age", &:age)
end
```

So how would we build this component? The `column` method can’t output HTML because we need to iterate over the columns once for the headers and then once for each row in our `@people` enumerable.

What we want to do here is yield the block early, allowing the parent component to add the columns, then we want to iterate over those columns several times when rendering. Let’s build this component step-by-step and then put it all together.

First, we’re going to need an initializer to take an enumerable of rows and store them for later. It will also create an instance variable to store an array of columns.

```ruby
def initialize(rows)
  @rows = rows
  @columns = []
end
```

Then we’re going to need a `column` method that takes a header and content and stores them in the columns array.

```ruby
def column(header, &content)
  @columns << { header:, content: }
end
```

Now, in our `view_template`, we can `yield`

```ruby
def view_template
  yield
end
```

Remember, yielding the block means the `column` method is being called from the parent component, and each time it’s pushing a new column into our `@columns` array. At this point, we shouldn’t have output any HTML since the columns method doesn’t call any HTML methods.

It is however possible that the parent component included some HTML in the block. We can use `vanish` to prevent this. `vanish` will yield the block and discard any output.

```ruby
def view_template(&)
  vanish(&)
end
```

So at this point, we’ve yielded the block and built our array of columns without outputting any HTML. We also have an enumerable of rows. We’re ready to build the template.

First, we’ll iterate over the columns and render each header.

```ruby
table do
  thead do
    @columns.each do |column|
      th { column[:header] }
    end
  end
end
```

Next, we’ll iterate over the rows and render a row of cells.

```ruby
tbody do
  @rows.each do |row|
    tr do
      @columns.each do |column|
        td { column[:content].call(row) }
      end
    end
  end
end
```

Because the content is a `Proc`, we can `call` it with a row.

Putting it all together, our table component should look like this.

```ruby
class Table < Phlex::HTML
  def initialize(rows)
    @rows = rows
    @columns = []
  end

  def view_template(&)
    vanish(&)

    table do
      thead do
        @columns.each do |column|
          th { column[:header] }
        end
      end

      tbody do
        @rows.each do |row|
          tr do
            @columns.each do |column|
              td { column[:content].call(row) }
            end
          end
        end
      end
    end
  end

  def column(header, &content)
    @columns << { header:, content: }
  end
end
```

And we can use the beautiful column-based interface we discussed before.

```ruby
render Table.new(@people) do |t|
  t.column("Name", &:name)
  t.column("Age", &:age)
end
```

## Rendering interface-yielding components from ERB <Badge type="danger" text="Rails" />

When you render a Phlex component from ERB, Phlex automatically wraps the yield in an adapter. The adapter essentially makes it as if each method called on the component was wrapped in a `capture`, which means you can use both techniques discussed above.

The Nav component can be rendered like this:

```erb
<%= render Nav do |nav| %>
  <%= nav.item("/") do %>
    <strong>Home</strong>
  <% end %>

  <%= nav.item("/about") do %>
    About
  <% end %>

  <%= nav.divider %>

  <%= nav.item("/contact") do %>
    Contact
  <% end %>
<% end %>
```

Because each call to `item`, `divider` is wrapped in a `capture`, it returns a string of HTML rather than pushing it to the Nav’s buffer. That means it’s compatible with ERB’s expectations.

The Table component can be rendered like this:

```erb
<%= render Table.new(@people) do |t|
  t.column("Name", &:name)
  t.column("Age", &:age)
end %>
```

Or like this

```erb
<%= render Table.new(@people) do |t| %>
  <% t.column("Name") do |person| %>
    <%= person.name %>
  <% end %>

  <% t.column("Age") do |person| %>
    <%= person.age %>
  <% end %>
<% end %>
```

Note we don’t need to use `<%=` tags on `t.column` since it is not expected to return HTML. It’s just building up the columns list ready to be rendered at the end. If we did use `<%=`, that would also be fine, since `capture` returns an empty string if there is no HTML output during the capture.
