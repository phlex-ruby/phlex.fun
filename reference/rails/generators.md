# Generators

## Component

```
bundle exec rails g phlex:component Card
```

This will generate a new `Card` component in `app/components/card.rb`.

## View

```
bundle exec rails g phlex:view Articles::Index
```

This will generate a new `Articles::Index` view in `app/views/articles/index.rb`.

## Install

```
bundle exec rails g phlex:install
```

This will generate:

1. a new initializer in `config/initializers/phlex.rb`
2. a base component class in `app/components/base.rb`
3. a base view class in `app/views/base.rb`
