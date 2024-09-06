# Tags

All non-depreacted HTML tags are defined as instance methods on `Phlex::HTML`. They take keyword arguments which get turned into HTML attributes, and blocks which become content for the tag.

## Attributes
Attributes are normally symbol keys, which get dasherized. If you need a special attribute that has underscores in it, you can use a string key instead.

::: code-group
```ruby
div(data_controller: "hello", "_special" => "value") do
  "Hello!"
end
```
```html
<div data-controller="hello" _special="value">
  Hello!
</div>
```
:::

Alternatively, if you have multiple nested attributes (like several `data-*` attributes) you can use a hash:

::: code-group
```ruby
div(data: { controller: "hello", action: "click->hello#show" }) do
  "Hello!"
end
```
```html
<div data-controller="hello" data-action="click->hello#show">
  Hello!
</div>
```
:::

The `class` and `style` attributes have special handling. If you use a hash value with the `class` key, it will work similarly to the Rails' `class_names` helper when passed a hash:

::: code-group
```ruby
is_active = true
is_disabled = false

div(class: { active: is_active, disabled: is_disabled }) do
  "Hello!"
end
```
```html
<div class="active">
  Hello!
</div>
```
:::

If you use a hash value with the `style` key, it will be converted to a CSS string:

::: code-group
```ruby
h1(style: { color: "red", font_size: "16px" }) do
  "Hello!"
end
```
```html
<h1 style="color: red; font-size: 16px;">
  Hello!
</h1>
```
:::

## Content

Content is always passed as a block to the tag method. The block content works differently depending on whether or not other tag methods are called inside the block.

If there are no other tag methods called inside the block, then the return value of the block is used as the content

::: code-group
```ruby
div do
  "Hello!"
end
```
```html
<div>
  Hello!
</div>
```
:::

If there are other tag methods called inside the block, then the return value of the block is ignored. Instead, if you need to pass string content outside of a nested tag, you can use the `plain` method.

::: code-group
```ruby
p do
  strong { "Hello" }
  plain " World!"
end
```
```html
<p>
  <strong>Hello</strong> World!
</p>
```
:::

If we wrote that without the `plain` method, we would be missing the ` World!` part.

::: code-group
```ruby
p do
  strong { "Hello" }
  " World!"
end
```
```html
<p>
  <strong>Hello</strong>
</p>
```
:::

That is because the `p` tag's block has another tag inside of it, so it ignores the return value of the block.
