# Attributes

In Phlex, HTML elements are rendered via method calls and the keyword arguments are the attributes. Phlex has an attribute builder that handles a number of different kinds of keys and values. Let’s start by looking at the keys.

## Attribute keys

Typically, keys will be passed as Ruby Symbols. When working with symbols, Phlex will replace underscores (`_`) with dashes (`-`). This is because the convention in HTML is to use dashes to separate each word in a symbol, while on the Ruby side dashes are not allowed in symbol literals.

If you need to keep an underscore in the attribute name, you can use a String as the key instead:

::: code-group

```ruby [Phlex]
h1(data_controller: "hello") { "Hello!" }
h1("data_controller" => "hello") { "Hello!" }
```

```html [HTML]
<h1 data-controller="hello">Hello!</h1>
<h1 data_controller="hello">Hello!</h1>
```

:::

::: tip
You need to use the “hash rocket” `=>` style with String keys in Ruby.
:::

## Attribute values

### Strings

String are output without modification, unless they contain double-quotes which will be escaped.

::: code-group

```ruby [Phlex]
input(name: "first_name")
```

```html [HTML]
<input name="first_name" />
```

:::

### Symbols

Phlex will replace underscores (`_`) with dashes (`-`) in Symbol values.

::: code-group

```ruby [Phlex]
div(contenteditable: :plaintext_only)
```

```html [HTML]
<div contenteditable="plaintext-only"></div>
```

:::

### Arrays and Sets

Arrays and Sets are compacted and joined with a space (` `).

```ruby
a(
  class: [
    ("button"),
    ("active" if is_active),
    ("disabled" if is_disabled)
  ]
) { "Click me" }
```

### Hashes

You can nest attributes by using a `Hash` as the value. The hash will be flattened with a dash (`-`) between each level:

::: code-group

```ruby [Phlex]
h1(data: { controller: "hello" }) { "Hello!" }
```

```html [HTML]
<h1 data-controller="hello">Hello!</h1>
```

:::

### Booleans

If the value is `true`, Phlex will render the attribute without a value. If the value is `false`, Phlex will not render the attribute at all.

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
Some HTML attributes such as `contenteditable` require you to pass `"true"` or `"false"` as strings. These are not really _boolean_ attributes even though they look similar. They’re technically _“enumerated”_ attributes.

According to [the MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/contenteditable), `contenteditable` accepts `"true"`, `"false"` or `"plaintext-only"`. The presence of this third option explains why `contenteditable` is not a boolean attribute. It also means new modes could be added in the future without breaking existing code.
:::

### Nil

Nil attributes will be ignored.

## Special cases

### The `style` attribute

The `style` attribute has special behaviour. If you pass a `Hash` as `style:`, Phlex will convert it to a CSS string rather than flattening it.

::: code-group

```ruby [Phlex]
h1(style: { color: "red", font_size: "16px" }) { "Hello!" }
```

```html [HTML]
<h1 style="color: red; font-size: 16px;">Hello!</h1>
```

:::

### `href` on an `<a>` tag

Phlex will not allow you to set the `href` attribute to anything that begins with `javascript:`. This is a security feature to prevent cross-site-scripting (XSS) attacks.

If you need to create a `javascript:` link, you can mark it as safe to bypass this security feature. You are responsible for the safety of strings you declare to be safe.

```ruby
a(href: safe("javascript:alert(1)")) { "Click me" }
```

### Event attributes

Event attributes such as `onclick` are disallowed to prevent cross-site-scripting (XSS) attacks.

If you need to set event attributes, you can mark them as safe to bypass this security feature. You are responsible for the safety of strings you declare to be safe.

```ruby
button(onclick: safe("alert(1)"))
```
