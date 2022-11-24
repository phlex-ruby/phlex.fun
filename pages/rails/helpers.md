---
title: Using Rails helpers in Phlex views
---

# Using Rails helpers in Phlex views

## The helpers proxy

You can use the `helpers` proxy to access any Rails helper from a Phlex view. For example, you can use the `#url_for` helper to get a url.

```ruby
module Views
  class Hello < Phlex::HTML
    def template
      a(href: helpers.url_for(Article)) { "Articles" }
    end
  end
end
```

## Layout helpers

Rails tag helpers return strings which makes them less than ideal to use from Phlex. Including `Phlex::Rails::Layout` gives you access to the following Rails helper proxies which immediately output to the buffer:

```phlex
ul {
	(Phlex::Rails::Layout.instance_methods - Module.methods).sort.each do |method|
		li { code { method } }
	end
}
```

Using these is equvalent to passing the output of the original Rails helpers to `unsafe_raw`, e.g:

```ruby
unsafe_raw helpers.javascript_include_tag
```

## Including proxies

The following modules can be included for direct access to these helpers. Note, helpers that produce HTML are adapted to output to the buffer directly.

```phlex
ul {
	Phlex::Rails::Helpers.constants.sort.each do |helper_module|
		li { code { helper_module } }
	end
}
```
