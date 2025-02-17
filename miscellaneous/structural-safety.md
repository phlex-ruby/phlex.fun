# Structural Safety

Phlex can provide strong HTML safety due to its structural design.

## What is cross-site-scripting?

Cross-site scripting (XSS) is when an attacker injects malicious scripts into websites that are then executed in other people’s browsers. As a simple example, what if one user says their name is `<script type="text/javascript">alert(1)</script>` and you subsequently display that user’s name to another unsuspecting user.

```ruby
dt { "Name" }
dd { @user.name }
```

If the second user sees the alert, that means the first user could have run any code in their browser logged in as them.

## How Phlex prevents cross-site-scripting

Phlex prevents cross-site-scripting in a number of different ways.

### Text content

All text content is escaped by default. There are five characters that can be used to construct dangerous strings in HTML and they are escaped according to this table:

| Original character | Escape   |
| ------------------ | -------- |
| `&`                | `&amp;`  |
| `<`                | `&lt;`   |
| `>`                | `&gt;`   |
| `"`                | `&quot;` |
| `'`                | `&#39;`  |

### Attribute keys

Because Phlex uses Ruby keyword arguments for attributes, it is possible that you might output unsafe strings in attribute keys.

```ruby
div(**@user.settings)
```

When rendering these attribute keys, Phlex looks for the unsafe characters and raises an error if any are found. In this case, it raises rather than escaping because it’s not a good idea to splat user data like this. The code should be fixed.

### Attribute values

Unlike attribute keys, it is reasonable to output user data in attribute values.

```ruby
input type: "text", value: @user.name
```

Phlex wraps attribute values in double quotes (`"`) so it escapes double quotes in the attribute values, replacing them with `&quot;`.

### Unsafe attributes

Some attributes are so unsafe, we completely prevent them by default, raising an error. If your Content Security Policy allows for unsafe inline JavaScript, the attribute `onclick` would execute its value as JavaScript when the element is clicked.

Phlex prevents the use of:

1. any attribute that starts with `on` and doesn’t contain a dash (`-`)
2. `srcdoc`
3. `sandbox`
4. `http-equiv`

::: tip

You can bypass this guard by branding the value as _safe_ with the `safe` method.

```ruby
button onclick: safe("alert(1)")
```

:::

### Ref attributes

Attributes that reference URLs can be used to execute JavaScript code by using the `javascript:` protocol. For example, if your Content Security Policy allows for unsafe inline JavaScript, this link would trigger a JavaScript alert when clicked:

```html
<a href="javascript:alert(1)">Click me</a>
```

Phlex strips the JavaScript protocol from the following ref attributes:

1. `href`
2. `src`
3. `action`
4. `formaction`
5. `lowsrc`
6. `dynsrc`
7. `background`
8. `ping`

Browsers are incredibly lenient in what they count as the JavaScript protocol so Phlex takes care to ignore whitespace, to match uppercase, lowercase or mixed case and to prevent ticks like `javascript:javascript:alert(1)`.

::: tip

You can bypass this guard by branding the value as _safe_ with the `safe` method.

```ruby
a(href: safe("javascript:alert(1)")) { "Click me" }
```

:::

## Additional measures

While Phlex makes every effort to prevent cross-site-scripting attacks by default, there are some additional measures you can take to be extra safe.

### Configure a strong Content Security Policy

We strongly recommend configuring a strong [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) (CSP) that does not allow unsafe-inline JavaScript. Please also see the [Rails Guide to configuring a Content Security Policy](https://guides.rubyonrails.org/security.html#content-security-policy-header).

### Don’t make a habit of branding things as safe

The `safe` method — and in Rails, calling `.html_safe` on a String — brand that string as HTML safe. Doing this bypasses security features and allows for the string to be output as HTML.

While it’s sometimes necessary to use this feature, it should be used carefully and kept close to the escaping/sanitization logic.

## Reporting security vulnerabilities

If you believe you have found a security vulnerability in Phlex, please do not open an issue or pull request. Instead, please [send us a private advisory](https://github.com/phlex-ruby/phlex/security/advisories/new) via GitHub.
