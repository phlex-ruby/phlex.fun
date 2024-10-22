# Kits

Kits allow you to render components in your templates without using the `render` method or calling `.new`.

## Setting Up a Kit

For this to work, the components need to be in a "Kit". A Kit is a special Ruby module that contains components. In your app, you might call this module `Components`, but you could name it anything. UI kits can ship gems with Phlex Kits in them.

To create a Kit, extend `Phlex::Kit` in your module:

```ruby
module Components
  extend Phlex::Kit
end
```
## Defining Components in a Kit
Define a component in the Kit like this:

```ruby
class Components::Card < Phlex::HTML
  def initialize(title)
    @title = title
  end
  
  def view_template(&)
    article(class: "card") {
      h1(class: "card-title") { @title }
      yield
    }
  end
end
```
When this component class is defined, a method will automatically be defined on the containing kit (Components) with the same name as the component. In this case, the method Card will be defined on Components.

## Using Kits
In another component, you can use that method to render the card without render or .new:

```ruby
def view_template
  Components::Card("Hello") { "Hello world!" }
end
```
::: tip
This syntax might look unfamiliar. It appears to be a constant lookup, but it's actually a method call to the Card method on the Components module.
:::

Use empty parentheses if the component takes no arguments:

```ruby
Components::Navigation()
```
## Including Kits in Components
You can include the Kit into a component to access these methods without the namespace:

```ruby
class Posts::IndexView < ApplicationView
  include Components
  
  def view_template
    Card("Hello") { "Hello world!" }
  end
end
```
All components in a Kit automatically include their own Kit, so they can reference other components in the same Kit.

## Compatibility with Autoloading
Kits are compatible with Ruby autoloading and Zeitwerk. If you call the method for a component before the component constant itself is called, it will be auto-loaded.

## Advantages of Capital-Letter Method Names
1. Direct mapping between the constant name and the method name
2. Better auto-completion with Language Servers
3. No conflicts with HTML element methods
4. Clear visual distinction for component boundaries
5. Follows conventions from JavaScript frameworks like Svelte and React

::: warning
If Rubocop complains about capital-letter method names, you may need to disable those rules.
:::

::: tip
If you prefer, you can continue using render Foo.new instead of this new syntax.
:::

