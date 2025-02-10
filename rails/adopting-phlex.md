# Adopting Phlex

## Starting from scratch

If you’re starting a new Rails app from scratch, you may want to go all-in with Phlex from the start, using Phlex for [_views_](views.html), [_layouts_](layouts.html) and _components_.

You should also consider using [Literal Properties](/miscellaneous/literal-properties.html), which will reduce the amount of boilerplate required for each component and add data validations at the component layer.

## Adopting Phlex in an existing codebase

If you’re adopting Phlex into an existing codebase, you should start by extracting components and using them in your existing Rails views. This will help you get the most out of Phlex early on without too much effort.

Eventually, you may decide to start building new views directly in Phlex or maybe even converting some of your existing views over.

Although there is a [compatibility layer](/layouts.html#working-with-legacy-layouts) if you need to convert them early, your layouts should probably be the last things to convert to Phlex.

## Tracking progress

I usually use `cloc` to track how much ERB is left in an application. In the Rails console, you can look at `Phlex::HTML.descendants.size` to see how many HTML components you have loaded in your app.
