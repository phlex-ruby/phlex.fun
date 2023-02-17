---
title: Rendering Phlex views in Rails
---

# Rendering Phlex views in Rails

You can render a Phlex view from your Rails controller actions or other views — Phlex, ActionView or ViewComponent.

Instead of implicitly rendering an ERB template with automatic access to all your controller instance variables, you’ll need to explicitly render Phlex views from your controller action methods.

```ruby
class ArticlesController < ApplicationController
	layout -> { ApplicationLayout }
	
  def index
    render Views::Articles::Index.new(
      articles: Article.all.load_async
    )
  end

  def show
    render Views::Articles::Show.new(
      article: Article.find(params[:id])
    )
  end
end
```
