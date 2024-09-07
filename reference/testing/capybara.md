# `Phlex::Testing::Capybara`

`Phlex::Testing::Capybara` is a test helper that makes it easy to render components and test them in isolation. It’s made available by requiring `phlex/testing` or `phlex/rails/testing`.

### `#render`

Use `#render` to render a component. The rendered component will be returned as a `Capybara::Node::Simple` and will also be assigned to the accessor `page`.

### `#page` and `#component`

After rendering a component with `#render`, you can reference the result with `#page` or `#component`. Depending on which testing framework you’re using, you may not need to reference the result directly.

## Minitest

When you include `Phlex::Testing::Capybara`, it will automatically include `Capybara::Minitest::Assertions` for you.

Here’s a minimal example:

```ruby
require "phlex/testing"

class Components::CardTest < ActiveSupport::TestCase
  include Phlex::Testing::Capybara

  test "renders a card" do
    render Components::Card.new(title: "Hello, world!")

    assert_selector ".card .card-title", text: "Hello, world!"
  end
end
```

::: tip

You may want to move the `require` up to a generic test helper and require that instead.

:::

## RSpec

```ruby
require "phlex/testing"

RSpec.describe Components::Card do
  include Phlex::Testing::Capybara

  it "renders a card" do
    render Components::Card.new(title: "Hello, world!")

    expect(component).to have_selector(
      ".card .card-title", text: "Hello, world!"
    )
  end
end
```

### Defining an RSpec spec type

If you’re using RSpec, you can define a custom spec type to include `Phlex::Testing::Capybara` automatically.

In your `spec_helper.rb` (or `rails_helper`) or wherever you configure RSpec, add the following configuration:

```ruby
RSpec.configure do |config|
  config.include Phlex::Testing::Capybara, type: :component # [!code ++:1]

  # ...
end
```

You’ll also need to require `phlex/testing` (or `phlex/rails/testing`) at the top of this file.

```ruby
require "phlex/testing"
```

::: tip
If you require `phlex/testing` or `phlex/rails/testing` in your configuration file, you don’t need to require it in your individual spec files.
