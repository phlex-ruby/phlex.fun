# Phlex Views in Rails

In Phlex, a view is really just another component, but views are not typically rendered inside other views. They’re usually the root and they usually start with a _doctype_ and end with `</html>`.

To help distinguish views from components, the install generator in `phlex-rails` creates a `Views` module and loads Ruby files in `app/views` under this module.

You can create a view with the generator. By convention, views should map to the names of your controllers and actions.

```
bundle exec rails g phlex:view Articles::Index
```

## Rendering a view

Now in your `ArticlesController`, you can render the view like this:

```ruby
class ArticlesController < ApplicationController
  def index
    render Views::Articles::Index.new(
      articles: Article.all
    )
  end
end
```
