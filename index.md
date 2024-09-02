---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Phlex"
  text: "Stunning server-side rendered views in Ruby"
  tagline: A little string concatenation library.
  actions:
    - theme: brand
      text: Get started
      link: /guide

features:
  - title: Pure Ruby
    icon: 💎
    details: Phlex gives you HTML semantics directly in Ruby syntax. You don’t need to learn a new templating language and you can use your existing Ruby skills to refactor views — methods, inheritance, loops and conditionals and data access are completely seamless.
  - title: Fast enough
    icon: 🚀
    details: Phlex renders HTML at over 1gbps on a MacBook Pro and unlike Rails partials, it doesn’t slow down the more you extract. You won’t need to cache your views anymore.
  - title: Kits
    icon: 🎒
    details: You can package components into kits for easy reuse across projects. Kits can be shared with the community as Ruby gems or kept private.
  - title: Structural safety
    icon: 🛡️
    details: Phlex is designed to prevent XSS attacks by default. It’s much easier to do this with a structural approach than with a string-based one such as ERB.
  - title: Selective rendering
    icon: 🔎
    details: You can render a view targeting a specific id. Phlex no-ops until it finds the content you’re looking for, then returns early with just the parts you wanted. This is great for partial Hotwire updates.
  - title: Rails integration
    icon: 🚂
    details: Phlex works great with Rails. It supports all Rails helpers and plays nicely with ViewComponent, ActionView, Stimulus, Turbo and Tailwind.
---
