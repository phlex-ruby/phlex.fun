---
prev: false
---

# Overview

Phlex is a Ruby gem for building object-oriented views directly in Ruby. It supports **HTML**, **SVG** and **CSV** views, but we’ll mostly focus on HTML views in this guide.

Phlex components are Ruby classes that describe discrete parts of your view. You may have a components for your _layout_, _header_ and _footer_ as well as abstract parts like _buttons_, _tables_, _form inputs_.

## HTML in Ruby?

When your browser parses an HTML file, it builds up a tree of elements, attributes, comments and text nodes.

HTML in this sense is something beyond the specific syntax of a text file. The HTML text file is just a way of serializing a HTML tree so it can be stored and delivered over the network.

When you think about it from this perspective, it doesn’t matter how the HTML tree is stored in source code, as long as there’s a reliable path to the browser.

Producing HTML from a web application requires some kind of templating to incorporate dynamic data from your application. There are two primary approaches to templating: string-based templating and structural templating.

In a string-based templating system, you are just concatenating strings together to hopefully produce a file that can be parsed as valid HTML. In ERB, for example, this means constantly switching between modes. In one mode, everything is part of the string output. In another mode, you’re executing the host language (Ruby). In a third mode, you’re executing Ruby and concatenating the results of computations.

With a structural templating system, you build a tree directly in the host language. Ruby is an excellent language for structural templating because of its support for nesting blocks and the implicit _self_ receiver.

Phlex uses Ruby methods, keyword arguments and blocks to describe an HTML tree _structurally_. When you’re working with a tree, it’s much easier to produce valid, safe HTML. For example, it’s impossible to forget to close an HTML tag, and you can’t output HTML that will execute unsafe code from user input.

Although the source code isn’t exactly HTML, the semantics of the tree are the same as HTML. And because everything is written in Ruby, there’s no mode-switching. You can also take advantage of standard Ruby tools like RubyLSP, RuboCop and SimpleCov.
