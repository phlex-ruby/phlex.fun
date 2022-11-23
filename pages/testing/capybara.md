---
title: Testing Phlex Views with Capybara
---

# Testing with Capybara

Require `phlex/testing/capybara` and include `Phlex::Testing::Capybara::ViewHelper` to use [Capybara](http://teamcapybara.github.io/capybara/) matchers.

The `render` method will return a `Capybara::Node::Simple` and set the `page` attribute to the result.

```phlex
example do |e|
  e.tab "test.rb", <<~RUBY
    require "phlex/testing/capybara"

    class TestExample < Minitest::Test
      include Phlex::Testing::Capybara::ViewHelper

      def test_example
        render Example.new("Joel")
        assert_select "h1", text: "Hello Joel"
      end
    end
  RUBY

  e.tab "hello.rb", <<~RUBY
    class Hello < Phlex::HTML
      def initialize(name)
        @name = name
      end

      def template
        h1 { "Hello \#{@name}" }
      end
    end
  RUBY
end
```
