# Literal Properties

When you build views with Phlex components, you end up creating a lot of small classes. And there can be quite a lot of boilerplate.

At one point, Phlex had a solution to this, but it has subsequently been extracted into a separate gem called [Literal](https://literal.fun). Literal and Phlex go well together, specifically [Literal Properties](https://literal.fun/docs/properties.html).

To use Literal Properties in Phlex, you just need to extend the `Literal::Properties` module. If you do this in your base component, you’ll be able to use `prop` in any of your component classes.

```ruby
class Components::Base < Phlex::HTML
  extend Literal::Properties
end
```

Now in your components, you can use `prop`.

```ruby
class Components::LinkButton < Components::Base
  Size = _Union(:small, :medium, :large)
  Variant = _Union(:primary, :success, :danger)

  prop :href, String
  prop :size, Size, default: :medium
  prop :variant, Variant, default: :primary
  prop :disabled, _Boolean, default: false

  def view_template
    # ...
  end
end
```

Check the [Literal docs](https://literal.fun) for usage guides.
