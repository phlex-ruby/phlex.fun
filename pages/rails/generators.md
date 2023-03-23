---
title: Phlex Rails Generators
---

# Rails Generators

## Component
```bash
bin/rails g phlex:component Card
```

This will generate a `CardComponent` in `card_component.rb` under `app/views/components`.

## View
```bash
bin/rails g phlex:view Articles::Index
```
This will generate a `Articles::IndexView` in `index_view.rb` under `app/views/articles`.

## Controller
```bash
bin/rails g phlex:controller Articles index show
```
This will generate an `ArticlesController` in `app/controllers`. It will have the actions `index` and `show`, which will render the views `Articles::IndexView` and `Articles::ShowView` generated in `index_view.rb` and `show_view.rb` under `app/views/articles`.
