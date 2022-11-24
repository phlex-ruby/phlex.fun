---
title: Testing Phlex Views
---

# Testing Phlex Views

The `Phlex::Testing::ViewHelper` module defines `render` allowing you to render Phlex views directly in your tests and make assertions against the output.

You’ll need to require `phlex/testing/view_helper` and include `Phlex::Testing::ViewHelper` your test.

```phlex
example do |e|
  e.tab "test/test_hello.rb", <<~RUBY
    require "phlex/testing/view_helper"

    class TestHello < Minitest::Test
      include Phlex::Testing::ViewHelper

      def test_hello_output_includes_name
        output = render Hello.new("Joel")
        assert_equal "<h1>Hello Joel</h1>", output
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
