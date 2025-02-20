---
title: Raw HTML output in Phlex
---

# Raw output

For the most part, you should be able to build your views using Phlex’ element methods. But sometimes you need to output raw HTML. Maybe it’s from another Gem such as a Markdown renderer.

To do this, you can use the `raw` method. As an extra precaution, `raw` will only output strings that are branded as safe. In `Phlex`, you can brand a string as safe with the `safe` method.

```ruby
raw safe(
  Commonmarker.to_html(@markdown)
)
```

In Rails, `ActiveSupport::SafeBuffer` objects are also considered safe.

You should avoid using `raw`. If you have to use it, you should avoid using `safe`. Most Rails gems that provide HTML will already mark it as safe if it is safe.

When you mark a string as `safe`, you are responsible for ensuring there is no unsafe HTML user content in that string. Phlex `raw` method completely bypasses its HTML safety features when given a safe string.
