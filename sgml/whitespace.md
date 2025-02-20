---
title: Inserting whitespace in Phlex HTML and SVG DSLs
---

# Whitespace

Phlex doesn’t render any whitespace around elements by default, but sometimes you need whitespace around inline elements so they can wrap. For this, you can use the `whitespace` method, which outputs a single space character.

::: code-group

```ruby [Ruby]
nav do
  a(href: "/") { "Home" }
  whitespace
  a(href: "/about") { "About" }
end
```

```html [HTML]
<nav><a href="/">Home</a> <a href="/about">About</a></nav>
```

:::

If passed a block, `whitespace` outputs a single space character before and after yielding the block.
