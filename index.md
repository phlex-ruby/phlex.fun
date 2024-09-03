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
  - title: Pure, beautiful Ruby
    icon: 💎
    details: Phlex gives you HTML semantics in Ruby syntax. You don’t need to learn a new templating language and you can use your existing Ruby skills. Extracting methods, inheritance, loops, conditionals and data access are completely seamless.
  - title: Fast enough
    icon: 🚀
    details: Phlex renders HTML at over 1gbps on a MacBook Pro and unlike Rails partials, it doesn’t slow down the more components you extract. You won’t need to cache your views anymore.
  - title: Kits
    icon: 🎒
    details: You can package up components into “kits” for easy reuse across projects. Kits can be shared with the community as Ruby gems or kept for internal use.
  - title: Structural safety
    icon: 🛡️
    details: Phlex is designed to prevent cross-site-scripting (XSS) attacks by default. It’s much easier to do this with a structural approach than with a string-based template such as ERB. Phlex knows exactly which attributes you are setting on which elements and can escape them accordingly.
  - title: Selective rendering
    icon: 🔎
    details: You can render a view targeting a specific deeply-nested id. Phlex no-ops until it finds the content you’re looking for, then returns early with just the parts you want. This is great for partial Hotwire updates.
  - title: Rails integration
    icon: 🚂
    details: Phlex works great with Rails. It supports all Rails helpers and plays nicely with ViewComponent, ActionView, Stimulus, Turbo and Tailwind. If you’re using Lookbook, it’s also supported there.
  - title: Streamable
    icon: 🌊
    details: Because Phlex generates HTML from top to bottom in sequential order, it can easily be streamed to the client on the fly. This can boost time to first byte (TTFB) and in some cases users can see static content at the top of the page before the dynamic content has even come back from the database.
  - title: Sensible isolation
    icon: 🧪
    details: Unlike Rails partials, which have access to any instance variable from the controller, Phlex components are isolated. For the most part, that means they only depend on the data you pass in. There are some exceptions where it makes sense to access the view context but generally they are much easier to test and reuse.
  - title: Zero dependencies
    icon: 📦
    details: Phlex has no dependencies and the Rails extension only depends on Rails itself (technically Railtie). What’s more, Phlex isn’t backed by a single company that could abandon it for React. The project is super low maintenance and will be around for a long time.
---
