# HTML

## Special HTML nodes

### `#comment`

Takes a block and wraps the output in an HTML comment.

::: code-group

```ruby [Ruby]
comment do
  h1 { "Hello" }
end
```

```html [HTML]
<!-- <h1>Hello</h1> -->
```

:::

### `#doctype`

Outputs an HTML doctype.

::: code-group

```ruby [Ruby]
doctype
```

```html [HTML]
<!doctype html>
```

:::

### `#plain`

Outputs plain text. This is necessary when plain text output is a sibling to other nodes.
Notice how “Hello” is output as plain text because it is the only node in the `<strong>`,
but we need to use `plain` explicitly for “World” since it is next to the `<strong>` node.

::: code-group

```ruby [Ruby]
h1 do
  strong { "Hello" }
  plain "World"
end
```

```html [HTML]
<h1><strong>Hello</strong>World</h1>
```

:::

### `#whitespace`

Outputs a single space character. If passed a block, outputs a single whitespace character before and after yielding the block.

::: code-group

```ruby [Ruby]
nav do
  a(href: "/") { "Home" }
  whitespace
  a(href: "/about") { "About" }
end
```

```html [HTML]
<nav><a href="/">Home</a> <a href="/about">About</a></nav>
```

:::

The space allows inline elements to wrap.

## HTML tags

| Ruby method   | HTML tag                                                                               |
| ------------- | -------------------------------------------------------------------------------------- |
| `#a`          | [`<a>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a)                   |
| `#abbr`       | [`<abbr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/abbr)             |
| `#address`    | [`<address>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/address)       |
| `#area`       | [`<area>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/area)             |
| `#article`    | [`<article>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/article)       |
| `#aside`      | [`<aside>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/aside)           |
| `#audio`      | [`<audio>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio)           |
| `#b`          | [`<b>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/b)                   |
| `#base`       | [`<base>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base)             |
| `#bdi`        | [`<bdi>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/bdi)               |
| `#bdo`        | [`<bdo>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/bdo)               |
| `#blockquote` | [`<blockquote>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/blockquote) |
| `#body`       | [`<body>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/body)             |
| `#br`         | [`<br>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/br)                 |
| `#button`     | [`<button>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button)         |
| `#canvas`     | [`<canvas>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas)         |
| `#caption`    | [`<caption>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/caption)       |
| `#cite`       | [`<cite>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/cite)             |
| `#code`       | [`<code>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/code)             |
| `#col`        | [`<col>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/col)               |
| `#colgroup`   | [`<colgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/colgroup)     |
| `#data`       | [`<data>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/data)             |
| `#datalist`   | [`<datalist>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/datalist)     |
| `#dd`         | [`<dd>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dd)                 |
| `#del`        | [`<del>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/del)               |
| `#details`    | [`<details>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details)       |
| `#dfn`        | [`<dfn>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dfn)               |
| `#dialog`     | [`<dialog>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog)         |
| `#div`        | [`<div>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/div)               |
| `#dl`         | [`<dl>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dl)                 |
| `#dt`         | [`<dt>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dt)                 |
| `#em`         | [`<em>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/em)                 |
| `#embed`      | [`<embed>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/embed)           |
| `#fieldset`   | [`<fieldset>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/fieldset)     |
| `#figcaption` | [`<figcaption>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figcaption) |
| `#figure`     | [`<figure>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure)         |
| `#footer`     | [`<footer>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/footer)         |
| `#form`       | [`<form>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form)             |
| `#h1`         | [`<h1>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h1)                 |
| `#h2`         | [`<h2>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h2)                 |
| `#h3`         | [`<h3>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h3)                 |
| `#h4`         | [`<h4>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h4)                 |
| `#h5`         | [`<h5>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h5)                 |
| `#h6`         | [`<h6>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/h6)                 |
| `#head`       | [`<head>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/head)             |
| `#header`     | [`<header>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/header)         |
| `#hgroup`     | [`<hgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/hgroup)         |
| `#hr`         | [`<hr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/hr)                 |
| `#html`       | [`<html>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/html)             |
| `#i`          | [`<i>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/i)                   |
| `#iframe`     | [`<iframe>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe)         |
| `#img`        | [`<img>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img)               |
| `#input`      | [`<input>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input)           |
| `#ins`        | [`<ins>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ins)               |
| `#kbd`        | [`<kbd>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/kbd)               |
| `#label`      | [`<label>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label)           |
| `#legend`     | [`<legend>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/legend)         |
| `#li`         | [`<li>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/li)                 |
| `#link`       | [`<link>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link)             |
| `#main`       | [`<main>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/main)             |
| `#map`        | [`<map>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/map)               |
| `#mark`       | [`<mark>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/mark)             |
| `#menu`       | [`<menu>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu)             |
| `#meta`       | [`<meta>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta)             |
| `#meter`      | [`<meter>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meter)           |
| `#nav`        | [`<nav>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/nav)               |
| `#noscript`   | [`<noscript>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/noscript)     |
| `#object`     | [`<object>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/object)         |
| `#ol`         | [`<ol>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ol)                 |
| `#optgroup`   | [`<optgroup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/optgroup)     |
| `#option`     | [`<option>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/option)         |
| `#output`     | [`<output>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/output)         |
| `#p`          | [`<p>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/p)                   |
| `#picture`    | [`<picture>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture)       |
| `#portal`     | [`<portal>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/)               |
| `#pre`        | [`<pre>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/pre)               |
| `#progress`   | [`<progress>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress)     |
| `#q`          | [`<q>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/q)                   |
| `#rp`         | [`<rp>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rp)                 |
| `#rt`         | [`<rt>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/rt)                 |
| `#ruby`       | [`<ruby>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/)                 |
| `#s`          | [`<s>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/s)                   |
| `#samp`       | [`<samp>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/samp)             |
| `#script`     | [`<script>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script)         |
| `#search`     | [`<search>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/search)         |
| `#section`    | [`<section>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/section)       |
| `#select`     | [`<select>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select)         |
| `#slot`       | [`<slot>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/slot)             |
| `#small`      | [`<small>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/small)           |
| `#source`     | [`<source>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/source)         |
| `#span`       | [`<span>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/span)             |
| `#strong`     | [`<strong>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/strong)         |
| `#style`      | [`<style>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/style)           |
| `#sub`        | [`<sub>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sub)               |
| `#summary`    | [`<summary>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary)       |
| `#sup`        | [`<sup>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup)               |
| `#svg`        | [`<svg>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/svg)               |
| `#table`      | [`<table>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)           |
| `#tbody`      | [`<tbody>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tbody)           |
| `#td`         | [`<td>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/td)                 |
| `#template`   | [`<template>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/template)     |
| `#textarea`   | [`<textarea>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea)     |
| `#tfoot`      | [`<tfoot>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tfoot)           |
| `#th`         | [`<th>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/th)                 |
| `#thead`      | [`<thead>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/thead)           |
| `#time`       | [`<time>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/time)             |
| `#title`      | [`<title>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/title)           |
| `#tr`         | [`<tr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/tr)                 |
| `#track`      | [`<track>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/track)           |
| `#u`          | [`<u>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/u)                   |
| `#ul`         | [`<ul>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ul)                 |
| `#var`        | [`<var>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/var)               |
| `#video`      | [`<video>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video)           |
| `#wbr`        | [`<wbr>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/wbr)               |
