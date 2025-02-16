---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Phlex 2.0"
  text: "Stunning server-side rendered views in Ruby"
  tagline: A little string concatenation library.
  actions:
    - theme: brand
      text: Documentation
      link: /introduction
    - theme: alt
      text: GitHub Repo
      link: https://github.com/phlex-ruby/phlex

features:
  - title: Pure, beautiful Ruby
    icon: 🧑‍🍳
    details: Phlex gives you HTML semantics in Ruby so you can use your existing skills designing object-oriented views.
  - title: Fast enough
    icon: 🚀
    details: Phlex renders HTML at ~1.4gbps per core on a MacBook Pro (M3 Max) and it doesn’t slow exponentially the more components you extract.
  - title: Rails integration
    icon: 🚂
    details: Phlex works great with Rails. It supports all Rails helpers and plays nicely with ERB, ViewComponent, Stimulus, Turbo and Tailwind.
  - title: Ruby tooling
    icon: 🧰
    details: Use tools like RubyLSP, RuboCop and SimpleCov.
  - title: Kits
    link: /components/kits.html
    icon: 🎒
    details: Package up components into Kits (Ruby modules) for easy reuse across projects.
  - title: Structural safety
    icon: 🛡️
    details: Phlex is designed to structurally prevent cross-site-scripting (XSS) attacks.
  - title: Sensible isolation
    icon: 🧪
    details: Phlex components only depend on the data you pass in, making them easier to test and reuse.
  - title: Zero dependencies
    icon: 📦
    details: Phlex has no dependencies and the Rails extension only depends on Rails itself.
  - title: Selective rendering
    link: /components/fragments.html
    icon: 🔎
    details: Render a view targeting a specific fragment of HTML and Phlex only does the work to render just the parts you want.
  - title: Streaming
    link: /components/streaming.html
    icon: 🌊
    details: Phlex can stream responses to improve time-to-first-byte (TTFB). Let users see content before the database has even responded.
  - title: Fragment caching
    link: /components/caching.html
    icon: 💵
    details: Rails-compatible fragment caching lets you control how different parts of your view are cached.
  - title: HTML / SVG string-builder
    icon: 🧵
    details: You can also use the Phlex DSL to build HTML and SVG strings directly, without creating a component class.
---
