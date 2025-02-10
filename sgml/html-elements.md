# HTML elements

For every HTML element, there’s a Ruby method with the same name. Standard Elements that take a content block yield the current component by default. The one exception is [`svg`](#svg), which yields a [`Phlex::SVG`](svg-elements.html) component.

## Custom elements

If you need to register a custom HTML element (e.g. for a web component) you can use the class method `register_element`. This will define an instance method that you can use in your template. Underscores (`_`) will be replaced with dashes (`-`).

```ruby
class Example < Phlex::HTML
  register_element :trix_editor

  def view_template
    trix_editor
  end
end
```

## `a`

Renders an [`<a>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a) element.

## `abbr`

Renders an [`<abbr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/abbr) element.

## `address`

Renders an [`<address>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/address) element.

## `area`

Renders an [`<area>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/area) element.

## `article`

Renders an [`<article>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/article) element.

## `aside`

Renders an [`<aside>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/aside) element.

## `audio`

Renders an [`<audio>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio) element.

## `b`

Renders a [`<b>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/b) element.

## `base`

Renders a [`<base>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base) element.

## `bdi`

Renders a [`<bdi>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/bdi) element.

## `bdo`

Renders a [`<bdo>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/bdo) element.

## `blockquote`

Renders a [`<blockquote>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/blockquote) element.

## `body`

Renders a [`<body>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/body) element.

## `br`

Renders a [`<br>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/br) element.

## `button`

Renders a [`<button>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button) element.

## `canvas`

Renders a [`<canvas>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas) element.

## `caption`

Renders a [`<caption>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/caption) element.

## `cite`

Renders a [`<cite>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/cite) element.

## `code`

Renders a [`<code>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/code) element.

## `col`

Renders a [`<col>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/col) element.

## `colgroup`

Renders a [`<colgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/colgroup) element.

## `data`

Renders a [`<data>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/data) element.

## `datalist`

Renders a [`<datalist>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/datalist) element.

## `dd`

Renders a [`<dd>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dd) element.

## `del`

Renders a [`<del>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/del) element.

## `details`

Renders a [`<details>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details) element.

## `dfn`

Renders a [`<dfn>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dfn) element.

## `dialog`

Renders a [`<dialog>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog) element.

## `div`

Renders a [`<div>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/div) element.

## `dl`

Renders a [`<dl>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dl) element.

## `dt`

Renders a [`<dt>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dt) element.

## `em`

Renders an [`<em>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/em) element.

## `embed`

Renders an [`<embed>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/embed) element.

## `fieldset`

Renders a [`<fieldset>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/fieldset) element.

## `figcaption`

Renders a [`<figcaption>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figcaption) element.

## `figure`

Renders a [`<figure>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure) element.

## `footer`

Renders a [`<footer>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/footer) element.

## `form`

Renders a [`<form>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form) element.

## `h1`

Renders an [`<h1>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h1) element.

## `h2`

Renders an [`<h2>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h2) element.

## `h3`

Renders an [`<h3>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h3) element.

## `h4`

Renders an [`<h4>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h4) element.

## `h5`

Renders an [`<h5>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h5) element.

## `h6`

Renders an [`<h6>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h6) element.

## `head`

Renders a [`<head>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/head) element.

## `header`

Renders a [`<header>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/header) element.

## `hgroup`

Renders a [`<hgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/hgroup) element.

## `hr`

Renders an [`<hr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/hr) element.

## `html`

Renders an [`<html>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/html) element.

## `i`

Renders an [`<i>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/i) element.

## `iframe`

Renders an [`<iframe>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) element.

## `img`

Renders an [`<img>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img) element.

## `input`

Renders an [`<input>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input) element.

## `ins`

Renders an [`<ins>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ins) element.

## `kbd`

Renders a [`<kbd>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/kbd) element.

## `label`

Renders a [`<label>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label) element.

## `legend`

Renders a [`<legend>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/legend) element.

## `li`

Renders an [`<li>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/li) element.

## `link`

Renders a [`<link>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link) element.

## `main`

Renders a [`<main>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/main) element.

## `map`

Renders a [`<map>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/map) element.

## `mark`

Renders a [`<mark>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark) element.

## `menu`

Renders a [`<menu>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu) element.

## `meta`

Renders a [`<meta>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta) element.

## `meter`

Renders a [`<meter>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meter) element.

## `nav`

Renders a [`<nav>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/nav) element.

## `noscript`

Renders a [`<noscript>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript) element.

## `object`

Renders an [`<object>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/object) element.

## `ol`

Renders an [`<ol>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ol) element.

## `optgroup`

Renders an [`<optgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/optgroup) element.

## `option`

Renders an [`<option>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/option) element.

## `output`

Renders an [`<output>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/output) element.

## `p`

Renders a [`<p>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/p) element.

## `picture`

Renders a [`<picture>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture) element.

## `portal`

Renders a [`<portal>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/) element.

## `pre`

Renders a [`<pre>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/pre) element.

## `progress`

Renders a [`<progress>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress) element.

## `q`

Renders a [`<q>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/q) element.

## `rp`

Renders an [`<rp>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rp) element.

## `rt`

Renders an [`<rt>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rt) element.

## `ruby`

Renders a [`<ruby>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/) element.

## `s`

Renders an [`<s>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/s) element.

## `samp`

Renders a [`<samp>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/samp) element.

## `script`

Renders a [`<script>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script) element.

## `search`

Renders a [`<search>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/search) element.

## `section`

Renders a [`<section>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/section) element.

## `select`

Renders a [`<select>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select) element.

## `slot`

Renders a [`<slot>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/slot) element.

## `small`

Renders a [`<small>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/small) element.

## `source`

Renders a [`<source>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/source) element.

## `span`

Renders a [`<span>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/span) element.

## `strong`

Renders a [`<strong>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/strong) element.

## `style`

Renders a [`<style>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/style) element.

## `sub`

Renders a [`<sub>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sub) element.

## `summary`

Renders a [`<summary>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary) element.

## `sup`

Renders a [`<sup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup) element.

## `svg`

Renders an [`<svg>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/svg) element. This method yields a new `Phlex::SVG` component.

```ruby
svg do |s|
  s.rect x: 10, y: 10, width: 100, height: 100
end
```

## `table`

Renders a [`<table>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table) element.

## `tbody`

Renders a [`<tbody>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tbody) element.

## `td`

Renders a [`<td>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/td) element.

## `template`

Renders a [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template) element.

## `textarea`

Renders a [`<textarea>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea) element.

## `tfoot`

Renders a [`<tfoot>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tfoot) element.

## `th`

Renders a [`<th>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/th) element.

## `thead`

Renders a [`<thead>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/thead) element.

## `time`

Renders a [`<time>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/time) element.

## `title`

Renders a [`<title>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/title) element.

## `tr`

Renders a [`<tr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tr) element.

## `track`

Renders a [`<track>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/track) element.

## `u`

Renders a [`<u>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/u) element.

## `ul`

Renders a [`<ul>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ul) element.

## `var`

Renders a [`<var>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/var) element.

## `video`

Renders a [`<video>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video) element.

## `wbr`

Renders a [`<wbr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/wbr) element.
