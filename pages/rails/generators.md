---
title: Phlex Rails Generators
---

# Rails Generators

## Layout
Generates a Phlex view for your layout including helpers from `Phlex::Rails::Layout`.

```bash
bin/rails g phlex:layout Layout
```

## Controller
```bash
bin/rails g phlex:controller Articles --actions index show
```

## Page
```bash
bin/rails g phlex:page Articles::Index
```

## View
```bash
bin/rails g phlex:view Article
```
