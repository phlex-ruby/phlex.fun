# Snippets

In some component systems — e.g. [Svelte](https://svelte.dev/docs/svelte/snippet) — snippets are a framework feature. They allow you to extract a small part of your template into a reusable snippet without extracting a whole component.

In Phlex, snippets are just methods. Like with any other Ruby class, you can extract a few lines of code into a method.

```ruby
class Sidebar < Phlex::HTML
  def view_template
    render_intro
    render_links
    render_footer
  end

  private

  def render_intro
    h2 "Welcome to the site!"
    p "This is the sidebar."
  end

  def render_links
    # ...
  end

  def render_footer
    # ...
  end
end
```

That’s it. Use _methods_ to make your components easier to understand and avoid deep nesting. And as you’ve already seen, if you make those methods public, you can call them in the content block from the parent component.
