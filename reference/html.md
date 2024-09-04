# `Phlex::HTML` < [`Phlex::SGML`](sgml.md)

## Instance methods

We’re not going to list them all here, but `Phlex::HTML` defines an instance method for every non-deprecated HTML element. See the MDN Web Docs for a [complete list](https://developer.mozilla.org/en-US/docs/Web/HTML/Element).

### `#doctype`

This outputs an [HTML5 doctype](https://developer.mozilla.org/en-US/docs/Glossary/Doctype) declaration:

```
<!doctype html>
```

### `#svg`

The `#svg` method is special because it yields an instance of [`Phlex::SVG`](svg.md) to the block. This allows you to create SVG content directly in your HTML:

```ruby
svg do |svg|
  svg.circle cx: 50, cy: 50, r: 40, fill: "red"
end
```
