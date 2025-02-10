# Comments

Phlex is just Ruby, so you can use regular Ruby comments to add context or disable part of your Phlex template. But if you want to output an HTML comment, you can use the `comment` method.

This method takes a block and wraps the output in an HTML comment.

::: code-group

```ruby [Phlex]
comment do
  h1 { "Hello" }
end
```

```html [HTML]
<!-- <h1>Hello</h1> -->
```

:::
