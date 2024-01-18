---
title: Testing Phlex Views with Capybara
---

# Testing with Capybara [beta]

The [`phlex-testing-capybara`](https://rubygems.org/gems/phlex-testing-capybara) gem provides a test helper that lets you use [Capybara](http://teamcapybara.github.io/capybara/) matchers.

## Installation

Add the following to the test group in your Gemfile and run `bundle install`.

```ruby
gem "phlex-testing-capybara"
```

## Usage

You’ll need to require `phlex/testing/rails/view_helper`, `phlex/testing/capybara` and include `Phlex::Testing::Rails::ViewHelper`, `Phlex::Testing::Capybara::ViewHelper`.


The `render` method will return a `Capybara::Node::Simple` and set the `page` attribute to the result.

```phlex
example do |e|
  e.tab "test.rb", <<~RUBY
    require "phlex/testing/capybara"

    class TestHello < Minitest::Test
      include Phlex::Testing::Capybara::ViewHelper

      def test_hello
        render Hello.new("Joel")
        assert_selector "h1", text: "Hello Joel"
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

### RSpec

If you're using RSpec you can include the modules for specs marked as `:component` by configuring this in the `spec/rails_helper` or `spec/spec_helper` files.

```phlex
example do |e|
  e.tab "spec/rails_helper", <<~RUBY
    require 'phlex/testing/rails/view_helper'
    require 'phlex/testing/capybara'

    RSpec.configure do |config|
      config.include Phlex::Testing::Rails::ViewHelper, type: :component
      config.include Phlex::Testing::Capybara::ViewHelper, type: :component
    end
  RUBY
	
  e.tab "hello_spec.rb", <<~RUBY
    require 'rails_helper'

    RSpec.describe 'Hello', type: :component do
      it 'renders something' do
        render(Hello.new("Joel"))

        expect(page).to have_css('h1', text: 'Hello Joel')
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
