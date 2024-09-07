# `Phlex::Testing::Capybara`

`Phlex::Testing::Capybara` is a test helper that makes it possible to test components in isolation using [Capybara](https://teamcapybara.github.io/capybara/).

> [!IMPORTANT]
> Before you include any Phlex testing helpers, you’ll need to require `phlex/testing`, or `phlex/rails/testing` if you’re using Rails. You can either require the helpers at the top of each test file or in a test helper or configuration file that’s loaded by your test suite.
>
> **Non-Rails**
>
> ```ruby
> require "phlex/testing"
> ```
>
> **Rails**
>
> ```ruby
> require "phlex/rails/testing"
> ```

### `#render`

Use `#render` to render a component. The rendered component will be returned as a `Capybara::Node::Simple`.

### `#page` and `#component`

After rendering a component with `#render`, you can reference the result with the `#page` or `#component` accessors. They both do the same thing so pick whichever reads better in your test.

## Minitest

When you include `Phlex::Testing::Capybara` in a `Minitest::Test` it will automatically include [`Capybara::Minitest::Assertions`](https://www.rubydoc.info/gems/capybara/Capybara/Minitest/Assertions) for you.

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

## RSpec

When you include `Phlex::Testing::Capybara` in an `RSpec::Core::ExampleGroup` it will automatically include [`Capybara::RSpecMatchers`](https://rubydoc.info/github/jnicklas/capybara/master/Capybara/RSpecMatchers) for you.

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

In your `spec_helper.rb`, `rails_helper` or wherever you configure RSpec, add the following configuration:

```ruby
RSpec.configure do |config|
  config.include Phlex::Testing::Capybara, type: :component # [!code ++:1]

  # ...
end
```

## Other testing frameworks

Not using Minitest or RSpec? You can probably still use `Phlex::Testing::Capybara` to render components and set the `#page` and `#component` accessors, but you might need to set up any matchers manually or work directly with the `Capybara::Node::Simple` object.
