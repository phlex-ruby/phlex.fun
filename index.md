---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Phlex"
  text: "Stunning server-side rendered views in Ruby"
  tagline: A little string concatenation library.
  actions:
    - theme: brand
      text: Guide
      link: /guide

features:
  - title: Pure, beautiful Ruby
    icon: 💎
    details: Phlex gives you HTML semantics in Ruby syntax. Don’t learn a new templating language, use your existing Ruby skills. Extracting methods, inheritance, loops, conditionals and data access are completely seamless.
  - title: Fast enough
    icon: 🚀
    details: Phlex renders HTML at over 1gbps on a MacBook Pro and unlike Rails partials, it doesn’t slow down the more components you extract.
  - title: Rails integration
    icon: 🚂
    details: Phlex works great with Rails. It supports all Rails helpers and plays nicely with ViewComponent, ActionView, Stimulus, Turbo and Tailwind.
  - title: Structural safety
    icon: 🛡️
    details: Phlex is designed to prevent cross-site-scripting (XSS) attacks by default.
  - title: Sensible isolation
    icon: 🧪
    details: Phlex components only depend on the data you pass in, making them easier to test and reuse.
  - title: Zero dependencies
    icon: 📦
    details: Phlex has no dependencies and the Rails extension only depends on Rails itself.
  - title: Kits
    icon: 🎒
    details: You can package up components into “kits” for easy reuse across projects. Kits can be shared with the community as Ruby gems or kept for internal use.
  - title: Selective rendering
    icon: 🔎
    details: You can render a view targeting a specific DOM ID. Phlex only does the work to render just the parts you want. This is great for partial Hotwire updates like Turbo Frames.
  - title: Streamable
    icon: 🌊
    details: Phlex can stream responses to boost time to first byte (TTFB). In some cases users can see static content before the database has even responded.
---
