# Phlex vs Slim

[Slim](https://slim-template.github.io)’s goal is reduce templating syntax to just the essential parts without becoming cryptic.

We can’t really make a direct comparison between Phlex and Slim because Slim is not a component framework and Phlex is not a templating language. However, there are some similarities between the two that we can look at. We can also get into why Phlex is designed around this idea of a “component”.

### Minimal templating syntax

If you’re using Slim, there’s a good chance you wanted something with a more minimal syntax than ERB, especially when it comes to switching between the HTML parts and the Ruby parts, such as an `if` conditional.

Phlex too has a pretty minimal syntax, with one significant difference: the Phlex syntax is just Ruby. You don’t need to learn anything else, you already know it. Modules, classes, methods, arguments, blocks. That’s it.

Because it’s just Ruby, the transition between the Ruby code and the template code is even more seamless. There’s no transition because it’s all Ruby. One factor to consider is Ruby doesn’t have significant whitespace.

### Components and abstraction

Phlex is designed around the idea of a “component”. A component is a Ruby class that represents a small part of the page. Extracting small components helps keep your user experience consistent and makes your code much easier to maintain in the long run.

Additionally, because Phlex is just Ruby, you can start by extracting methods.

```ruby
def MyButton(...)
  button(class: "my button classes", ...)
end
```

When you realise you need more options, you can upgrade that to a class.

```ruby
class Components::MyButton < Components::Base
  def initialize(style:, color:)
    @style = style
    @color = color
  end

  def view_template(&)
    button(class: [@style, @color], &)
  end
end
```
