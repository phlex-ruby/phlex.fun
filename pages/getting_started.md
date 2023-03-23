---
title: Setup Phlex
---

# Getting started with Phlex

If you’re using Phlex with [Ruby on Rails](https://rubyonrails.org), you should follow [this guide](/rails/) instead.

To install Phlex, first add `phlex` to your `Gemfile`.

```ruby
gem "phlex"
```

Then run:

```bash
bundle install
```

You may need to require `phlex` to be able to use it unless your application framework automatically requires bundled gems.

```ruby
require "phlex"
```

Now you can inherit from `Phlex::HTML` or `Phlex::SVG` to define your own components.

Here’s an example of a small [Sinatra](https://sinatrarb.com) app using Phlex.

```ruby
require "phlex"
require "sinatra"

get("/") { IndexView.call }

class IndexView < Phlex::HTML
	def template
		h1 { "👋 Hello World!" }
	end
end
```
