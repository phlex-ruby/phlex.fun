# Upgrading to v2

While we’ve tried to keep breaking changes to a minimum, there are a few things you will need to be aware of when upgrading from Phlex v1 to v2.

The latest version of v1 contains a number of deprecations, so we recommend upgrading to the latest version of v1 first.

## Breaking changes

### `template` → `view_template`

Instead of defining the `template` method for your component templates, you should instead define `view_template`.

### `template_tag` → `template`

To render [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template) elements in a `Phlex::HTML` component, you need to call the `template` method instead of the original `template_tag` method.

### We removed `tokens` and `classes`

If you need these back, you can always copy their original implementation from here, paste them into a helper module and include it in your `ApplicationComponent`.

However, we recommend using the new standard capabilities of attributes.

## New features

### Kits

Originally previewed in v1, kits are now out of beta and fully supported in v2. Kits are a way to package up a set of components into a module.

### Selective rendering

### A better cache

Phlex v2 introduces a new attribute cache that caches more things. We wrote about some of the technical details [here](/design/caching).
