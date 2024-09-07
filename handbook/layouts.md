# Layouts

In Phlex, _everything is a component_. A “view” is just a component that renders an entire HTML document — typically starting with `<doctype html>` and ending with `</html>`. Views are also entrypoints — they’re typically rendered directly from controllers.

In this world of components, where do _layouts_ fit in? Rails’ built-in view library, ActionView, has a special concept of layouts where they are separate from the rest of your views/partials and treated differently. ActionView renders the views and partials first and then wraps the view in a layout right at the end.

There are a few problems with this approach:

1. it adds complexity to the rendering process — there’s a whole different concept to understand with special rules; and
2. it makes it impossible to stream the response to the client until both the view and the layout are ready.

In Phlex, layouts are just components.

## Layouts through composition

The simplest way to implement layouts in Phlex is through _composition_. You render the view from the controller and the first thing the view does is render the layout component.

::: code-group

```ruby{2,5} [controller]
class ArticlesController < ApplicationController
  layout false

  def index
    render Views::Articles::Index.new(
      articles: Article.all.limit(10)
    )
  end
end
```

```ruby{7,15} [view]
class Views::Articles::Index < Views::Base
  def initialize(articles:)
    @articles = articles
  end

  def view_template
    Layout(title: "Articles") do
      h1 { "Articles" }

      ul do
        @articles.each do |article|
          li { article.title }
        end
      end
    end
  end
end
```

```ruby{14} [layout]
class Components::Layout < Components::Base
  def initialize(title:)
    @title = title
  end

  def view_template
    doctype

    html do
      head do
        title { @title }
      end

      body { yield }
    end
  end
end
```

:::

## Layouts through inheritance

Another way to implement layouts in Phlex is through inheritance. You create a base class for your views to inherit from, and that base view actually renders the layout around the template.

In this example, we use the `around_template` hook. Alternatively, we could have just defined a `view_template` method in the base class and called `super` from the view.

::: code-group

```ruby [controller]
class ArticlesController < ApplicationController
  layout false

  def index
    render Views::Articles::Index.new(
      articles: Article.all.limit(10)
    )
  end
end
```

```ruby [view]
class Views::Articles::Index < Views::Base
  def initialize(articles:)
    @articles = articles
  end

  def page_title = "Articles"

  def view_template
    h1 { "Articles" }

    ul do
      @articles.each do |article|
        li { article.title }
      end
    end
  end
end
```

```ruby{2,10} [base view (layout)]
class Views::Base < Phlex::HTML
  def around_template
    doctype

    html do
      head do
        title { page_title }
      end

      body { super }
    end
  end
end
```

:::

Notice in the above example how we use a method on the view to set the title of the page.

## Combining inheritance and composition

The final approach is to combine both inheritance and composition.

::: code-group

```ruby [controller]
class ArticlesController < ApplicationController
  layout false

  def index
    render Views::Articles::Index.new(
      articles: Article.all.limit(10)
    )
  end
end
```

```ruby{6-7} [view]
class Views::Articles::Index < Views::Base
  def initialize(articles:)
    @articles = articles
  end

  def page_title = "Articles"
  def layout = Layout

  def view_template
    h1 { "Articles" }

    ul do
      @articles.each do |article|
        li { article.title }
      end
    end
  end
end
```

```ruby{2,5,11-13} [base view]
class Views::Base < Phlex::HTML
  PageInfo = Data.define(:title)

  def around_template
    render layout.new(page_info) do
      super
    end
  end

  def page_info
    PageInfo.new(
      title: page_title
    )
  end
end
```

```ruby{3,11} [layout]
class Components::Layout < Components::Base
  def initialize(page_info)
    @page_info = page_info
  end

  def view_template
    doctype

    html do
      head do
        title { @page_info.title }
      end

      body { yield }
    end
  end
end
```

:::

This final example has quite a lot going on, but it’s extremely flexible.

- the controller renders the view as normal
- the view defines `#page_title` and `#layout` methods
- the base view uses the `#around_template` hook to render the layout that was specified by the view
- it passes a `page_info` object to the layout component containing the page title
- finally, the layout takes the `page_info` object and renders as normal

## Working with legacy layouts

[WIP]
