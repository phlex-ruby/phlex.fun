# Attributes deep dive

You’ve just rebuilt 90% of Phlex so you know a thing or two about rendering attributes, right?

In the previous example, we rendered attributes like this:

```ruby
attributes.each do |key, value|
  @buffer << " #{key}=\"#{value}\""
end
```

## Keys

If you use symbols for keys, Phlex will replace underscores `_` with dashes `-`. This is because the convention in HTML is to use dashes, while on the Ruby side, dashes are not allowed in symbols.

If you need to keep an underscore in the attribute name, you can use a string instead:

::: code-group

```ruby [component]
h1(data_controller: "hello") { "Hello!" }
h1("data_controller" => "hello") { "Hello!" }
```

```html [output]
<h1 data-controller="hello">👋 Hello World!</h1>
<h1 data_controller="hello">👋 Hello World!</h1>
```

:::

## Nested attributes

You can nest attributes by using a hash as the value. The hash will be flattened with a dash between each level:

::: code-group

```ruby [component]
h1(data: { controller: "hello" }) { "Hello!" }
```

```html [output]
<h1 data-controller="hello">👋 Hello World!</h1>
```

:::

## Attribute values

### Symbols

Like keys, if you use symbols for values, Phlex will convert them to strings, replacing underscores `_` with dashes `-`.

::: code-group

```ruby [component]
div(contenteditable: :plaintext_only)
```

```html [output]
<div contenteditable="plaintext-only"></div>
```

:::

### Arrays and sets

::: code-group

```ruby
a(
  class: [
    ("button"),
    ("active" if is_active),
    ("disabled" if is_disabled)
  ]
) { "Click me" }
```

:::

### Booleans

Booleans are a special case. If the value is `true`, Phlex will render the attribute without a value. If the value is `false`, Phlex will not render the attribute at all.

::: code-group

```ruby [component]
textarea(disabled: true)
textarea(disabled: false)
```

```html [output]
<textarea disabled></textarea> <textarea></textarea>
```

:::

::: tip
Some HTML attributes such as `contenteditable` require you to pass `"true"` or `"false"` as strings. These are not really _boolean_ attributes even though they look similar; they’re technically _“enumerated”_ attributes.

According to [the MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/contenteditable), `contenteditable` accepts `"true"`, `"false"` or `"plaintext-only"`. The presence of this third option explains why `contenteditable` is not a boolean attribute. It also means new modes could be added in the future without breaking existing code.

:::

## The `style` attribute

The `style` attribute has special behaviour. If you pass a Hash to `style`, Phlex will convert it to a CSS string:

::: code-group

```ruby [component]
h1(style: { color: "red", font_size: "16px" }) { "Hello!" }
```

```html [output]
<h1 style="color: red; font-size: 16px;">Hello!</h1>
```

:::

## `href` on an `<a>` tag

It’s worth noting here that Phlex will not allow you to set the `href` attribute to anything that begins with `javascript:`. This is a security feature to prevent cross-site-scripting (XSS) attacks.

## Event attributes

Event attributes such as `onclick` are disallowed to prevent cross-site-scripting (XSS) attacks.
