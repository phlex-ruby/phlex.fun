# Streaming Phlex views from Rails

Phlex’ extension for Rails allows you to stream views from your Rails controllers.

First, you’ll need to make sure you’re not using Rails' layout system. Rails’ layout system renders things out of order which prevents streaming.

To disable layouts, you can add `layout false` to your controller. If this is a new application, or if you’ve migrated entirely to Phlex, you may want to do this in your `ApplicationController`.

Next, you’ll need to include Phlex’ streaming helpers. Just include the module `Phlex::Rails::Streaming`.

Now you can use the `stream` method in your controller instead of `render`.

```ruby
class ArticlesController < ApplicationController
  include Phlex::Rails::Streaming

  def index
    stream Articles::IndexView.new(
      articles: Article.all
    )
  end
end
```
