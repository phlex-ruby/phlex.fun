---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Phlex <span style='font-size: 0.5em'>(pre release)</span>"
  text: "Stunning server-side rendered views in Ruby"
  tagline: A little string concatenation library.
  actions:
    - theme: brand
      text: Handbook
      link: /handbook/
    - theme: alt
      text: Reference
      link: /reference/

features:
  - title: Pure, beautiful Ruby
    icon: 🧑‍🍳
    details: Phlex gives you HTML semantics in Ruby so you can use your existing skills designing object-oriented views. Plus, you get to use tools like RubyLSP, Rubocop and Simplecov.
  - title: Fast enough
    icon: 🚀
    details: Phlex renders HTML at ~1gbps per core on a MacBook Pro (M3 Max) and it doesn’t slow down the more components you extract.
  - title: Rails integration
    icon: 🚂
    details: Phlex works great with Rails. It supports all Rails helpers and plays nicely with ViewComponent, ActionView, Stimulus, Turbo and Tailwind.
  - title: Structural safety
    icon: 🛡️
    details: Phlex is designed to structurally prevent cross-site-scripting (XSS) attacks by default.
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
  - title: Streaming
    icon: 🌊
    details: Phlex can stream responses to boost time to first byte (TTFB). In some cases users can see the first static content before the database has even responded.
---
