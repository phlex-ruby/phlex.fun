# Text

You can output plain text with the `plain` method.

```ruby
plain "Hello, world!"
```

## Implicit text output from blocks

When passing a block, if the block doesn’t render any HTML elements (or otherwise modify the buffer), Phlex will output the return value of the block as plain text.

```ruby
h1 { "Hello World" }
```

If you wanted to wrap “Hello” in a `<strong>` tag, you would need to use `strong` and `plain` together.

```ruby
h1 do
  strong { "Hello" }
  plain " World"
end
```

This is because `strong` outputs HTML, the return value of the block passed to `h1` will not be rendered.
