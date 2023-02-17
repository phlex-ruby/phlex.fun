---
title: Using Rails helpers in Phlex views
---

# Using Rails Helpers

Phlex aims to ship with an adapter for every Rails view helper. (Please open an issue if we're missing one.)

Each adapter can be included from its own module under `Phlex::Rails::Helpers`, e.g. `Phlex::Rails::Helpers::ContentFor`. The module name will match the title-cased method name.

You can include these adapters as needed, or include the ones you use most commonly in `ApplicationComponent` or `ApplicationView`.

If you need to call the original unadapted helper, you can do that through the `helpers` proxy. For example, `helpers.link_to "Home", "/"` will return the HTML link as a String, while the adapter would output it.