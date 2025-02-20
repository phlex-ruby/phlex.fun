---
title: Streaming Phlex components
---

# Streaming

We mentioned you can pass a custom output buffer to `call` when rendering a component from the outside. Using this technique, each time the component flushes its internal buffer to the output buffer, you can stream the output over the network.

## Streaming from Rails <Badge type="danger" text="Rails" />

You can include `Phlex::Rails::Streaming` into a Rails controller to stream Phlex views from Rails. This does not work if you need to use standard Rails layouts.

Now you can swap `render` for `stream` in your controller actions.

```ruby
def index
  stream Views::Articles::Index.new(
    articles: Article.all
  )
end
```

There is rarely much advantage to streaming, but it can help if your views spend significant amounts of time waiting on asynchronous IO.

Without additional tooling built around streaming capabilities, it’s probably not worth it for most situations, especially as Phlex only flushes after `</head>` by default while rendering.
