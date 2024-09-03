# Rails Helpers

Phlex’ Rails extension includes an adapter for each Rails helper. (Please open an issue if we’re missing one.)

Each adapter can be included from its own module under `Phlex::Rails::Helpers`. For example, the `link_to` helper can be included from `Phlex::Rails::Helpers::LinkTo`.

You can include these adapters as needed and you’ll probably want to include the most common ones in an abstract super class, e.g. `ApplicationComponent` or `ApplicationView`.
