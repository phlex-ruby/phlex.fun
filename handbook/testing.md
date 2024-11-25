# Testing

(Other frameworks TBD.)

## Testing in Rails

1. In `Gemfile`, add the `capybara` gem:

```
group :test do
  gem "capybara"
end
```

2. In `test_helper.rb`, add the following line somewhere above `module ActiveSupport`:

```
require "phlex/rails/testing"
```

3. Create test cases like `tests/components/my_component_test.rb`:

```
class Components::MyComponentTest < ActiveSupport::TestCase
  include Phlex::Testing::Capybara
  test "it should render a submit button" do
    render Components::MyComponent.new

    assert_selector "submit[name='hello_world']"
  end
end
```
