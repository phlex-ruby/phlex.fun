---
title: Testing Phlex Views with Nokogiri
---

# Testing HTML Views with Nokogiri [beta]

The [`phlex-testing-nokogiri`](https://rubygems.org/gems/phlex-testing-nokogiri) gem provides helpers for working with rendered views as [Nokogiri](https://nokogiri.org) documents and fragments.

## Installation
Add the following to the test group in your Gemfile and run `bundle install`.

```ruby
gem "phlex-testing-nokogiri"
```

## Testing Documents

If your view represents a whole HTML document, you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::DocumentHelper` module to render your view as `Nokogiri::Document` using the `render` method.

```phlex
example do |e|
  e.tab "test.rb", <<~RUBY
    require "phlex/testing/nokogiri"

    class TestExample < Minitest::Test
      include Phlex::Testing::Nokogiri::DocumentHelper

      def test_example
        output = render Example.new
        assert_equal "Hello Joel", output.css("h1").text
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
## Testing Fragments

If your view represents a fragment (partial), you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::FragmentHelper` module to render your view as `Nokogiri::Fragment` with the `render` method.

```phlex
example do |e|
  e.tab "test.rb", <<~RUBY
    require "phlex/testing/nokogiri"

    class TestExample < Minitest::Test
      include Phlex::Testing::Nokogiri::FragmentHelper

      def test_example
        output = render Example.new("Joel")
        assert_equal "Hello Joel", output.css("h1").text
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
