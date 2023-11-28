---
title: Using Rails helpers in Phlex views
---

# Using Rails Helpers

Phlex aims to ship with an adapter for every Rails view helper.

Each adapter can be included from its own module under `Phlex::Rails::Helpers`, e.g. `Phlex::Rails::Helpers::ContentFor`. The module name will match the title-cased method name. The full list of implemented helpers adapters can be viewed in the [helpers.rb source file](https://github.com/phlex-ruby/phlex-rails/blob/main/lib/phlex/rails/helpers.rb). If the Rails helper is missing, please open an [issue requesting it](https://github.com/phlex-ruby/phlex-rails/issues) or [implement it and open a pull request](https://github.com/phlex-ruby/phlex-rails/pulls).

You can include these adapters as needed, or include the ones you use most commonly in `ApplicationComponent` or `ApplicationView`.

## Why are adapters needed?

Rails helpers interact with the output buffers in different ways; thus an adapter is needed to deal with these differences.

## What if I need to call an unadapted helper?

If you need to call the original unadapted helper, you can do that through the `helpers` proxy. For example, `helpers.link_to "Home", "/"` will return the HTML link as a String, while the adapter would output it. It’s perfectly fine to do something like this directly instead, especially if you don’t need to worry about capturing blocks.

```
def svg_icon(...)
  unsafe_raw helpers.svg_icon(...)
end
```

If you want to be extra safe, you could check that the helper returns a safe string before passing it to unsafe_raw.

```
def svg_icon(...)
  output = helpers.svg_icon(...)
  
  if ActiveSupport::SafeBuffer === output
    unsafe_raw output
  end
end
```

For more details, or if you have questions, please read and participate in the [Github Discussion](https://github.com/orgs/phlex-ruby/discussions/594).

## Consider not using Rails helpers

These adapters exist to make it easier to integrate Phlex into existing Rails applications; however, using Rails helper tags doesn't take full advantage of the composability Phlex offers application developers.

For example, the [Superform]([https](https://github.com/rubymonolith/superform)https://github.com/rubymonolith/superform) library implements a Rails form helper, from scratch with Phlex components, that makes it possible to fully extend Phlex tags and do other things Rails form helpers can't, like automatically permit strong parameters.

The Phlex project encourages Rails developers to think outside of the "Rails view helper box" to create an ecosystem of Phlex helpers that give Rails developers more powerful abstractions for building front-end UI.
