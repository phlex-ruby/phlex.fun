---
title: Fragments and selective rendering in Phlex
---

# Fragments <Badge type="tip" text="experimental" />

The `fragment` helper allows you to define named template fragments which can be targeted while rendering.

```rb
class MyComponent < Phlex::HTML
  def view_template
    section do
      fragment("my-list") do  # Explicitly declare renderable fragment [!code ++]
        ul do
          li { "Item 1" }
          li { "Item 2" }
        end
      end # [!code ++]
    end
  end
end
```

Now you can render specific fragments by passing in a list of target fragments to the `call` method.

```ruby
MyComponent.new.call(fragments: ["my-list"])
```

When fragments are cached, Phlex also stores the byte ranges of each fragment. Then it can slice just the fragments you’re looking for from the cache.

You should be able to use `cache` and `fragment` together without any problems.
