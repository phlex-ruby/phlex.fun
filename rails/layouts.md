# Layouts

In this world of components, where do _layouts_ fit in? Rails, has a special concept for layouts where they are separate from the rest of your views and partials. ActionView renders the the inner parts of your view first and then wraps it up in a layout at the last moment.

There are a few problems with this approach:

1. it adds complexity to the rendering process — there’s a new concept to understand with special rules;
2. it necessitates the `content_for` helper and strange `yield` behaviours in order to hoist content from the view up into the layout; and
3. it makes it impossible to stream the response to the client until both the inner view and the layout are ready, which is only the case right at the end.

In Phlex, layouts are just components.

## Layouts through composition

The simplest way to implement layouts in Phlex is through _composition_. You render a view from a controller and the first thing the view does is render a layout component, passing content via a block.

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

```ruby{7} [view]
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

::: tip
You can put `layout false` in your `ApplicationController` to disable Rails’ built-in layout system across all your controllers.
:::

## Layouts through inheritance

Another way to implement layouts in Phlex is through inheritance. You create an abstract base view class for your views to inherit from, and that base view actually renders the layout around the template.

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

```ruby{6} [view]
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

Notice in the above example how we use a method to set the title of the page. The super class could call the method, requiring the subclass to implement it.

::: tip
In this example, we used the `around_template` hook. Alternatively, we could have just defined a `view_template` method in the base class and called `super` from the `view_template` implementation in the subclass.
:::

## Combining inheritance and composition

The final approach is to combine both inheritance and composition. This final example has quite a lot going on, but it’s extremely flexible.

- the controller renders the view as normal
- the view defines `#page_title` and `#layout` methods
- the base view uses the `#around_template` hook to render the layout component that was specified by the view
- it passes a `page_info` object to the layout component containing the page title
- finally, the layout takes the `page_info` object and renders as normal

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
	include Components

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

## Working with legacy layouts

If you’re bringing Phlex into an existing Rails app, there’s no urgent need to convert your layouts. In fact, the layouts are probably the lowest priority.

You’ll get way more benefits from extracting small, reusable components since you can immediately start rendering them in both your new Phlex views and your old Rails views. Plus, your new Phlex views will render just fine inside normal Rails layouts.

With that said, there _is_ a way to write your layouts in Phlex while still rendering normal non-Phlex views, though you won’t be able to use streaming.

If you include `Phlex::Rails::Layout` in a component, it can be used as a normal Rails layouts. You can even yield symbols to get `content_for` blocks.

```ruby{2,9}
class Components::Layout < Components::Base
  include Phlex::Rails::Layout

  def view_template
    doctype

    html do
      head do
        title { yield(:title) }
      end

      body { yield }
    end
  end
end
```

In the controller, you need to specify the layout with a block like this.

```ruby
class ArticlesController
  layout { Components::Layout }
end
```
