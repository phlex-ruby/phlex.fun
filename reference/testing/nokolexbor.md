# `Phlex::Testing::Nokolexbor`

`Phlex::Testing::Nokolexbor` is a test helper that makes it possible to test components in isolation using [Nokolexbor](https://github.com/serpapi/nokolexbor).

> [!IMPORTANT]
> Before you include any Phlex testing helpers, you’ll need to require `phlex/testing`, or `phlex/rails/testing` if you’re using Rails. You can either require the helpers at the top of each test file or in a test helper or configuration file that’s loaded by your test suite.
>
> **Non-Rails**
>
> ```ruby
> require "phlex/testing"
> ```
>
> **Rails**
>
> ```ruby
> require "phlex/rails/testing"
> ```

### `#render_fragment`

Returns the rendered component as a `Nokolexbor::DocumentFragment`, which you can then make assertions against.

### `#render_document`

Returns the rendered component as a `Nokolexbor::Document`. Use this if the component you’re testing is a full HTML document. That means it starts with a `doctype` and has `html`, `head`, and `body` tags.
