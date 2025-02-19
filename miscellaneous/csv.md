# CSV

## Introduction

Phlex also has a CSV table builder interface that should make you feel right at home if you're already comfortable working within Phlex. It carries over Phlex's design principles of safety, speed, and streamability.

Let's take a quick look at a CSV representing an export of users.

```ruby
class UserExport < ApplicationCSV
  def row_template(user)
    column("id", user.id)
    column("first_name", user.first_name)
    column("last_name", user.last_name)
    column("email", user.email)
  end
end
```

And we can call it the usual way:

::: code-group
```ruby
users = User.all

UserExport.new(users).call
```
```csv
id,first_name,last_name,email
1,Buster,Bluth,buster@example.com
2,Maeby,Fünke,maeby@example.com
```
:::

Nice! Ok, so what's actually happening? We initialize the CSV component with a collection of users, and when we call `call` on the component, it executes our `row_template` method for each item in the collection. The `column` method is pushing the header name, and the corresponding value into the CSV.

## Safety

There are some really cool features I want to show you about `Phlex::CSV`, but first we need to talk about safe CSVs. Spreadsheet programs that are often used to view CSVs are vulnerable to injection attacks when cells are interpreted as containing formulae. However CSVs are often used as a data interchange format between computer programs, and "escaping" values for a spreadsheet program would just be mangling your data.

So there's unfortunately no good default assumption we can make. So you have to make it. If the intended use for your CSVs are to be consumed by humans, likely through a spreadsheet program, then you need to define:

```ruby
def escape_csv_injection? = true
```

If, on the other hand, you're producing CSVs that are meant to be imported by some other software, and you need the data to be unaltered, you should define:

```ruby
def escape_csv_injection? = false
```

If you do not set this method, you will get a runtime error raised when you run `call`.

For more information about CSV formula injection, see [OWASPs explanation](https://owasp.org/www-community/attacks/CSV_Injection) on it.

If, like many people, almost all of your CSV reports fall in to one category or another, it can be easiest to define a base class in your application with this method defined:

```ruby
class ApplicationCSV < Phlex::CSV
  def escape_csv_injection? = true
end
```

## Trimming whitespace

Depending on the source of your data, it can be helpful to have the values trimmed of any leading or trailing whitespace. To opt-in to this, you can define a `trim_whitespace?` method. By default, it is `false`, and preserves any value you pass to a `column`.

```ruby
class ApplicationCSV < Phlex::CSV
  def trim_whitespace? = true
end
```

With this method defined, values will have `strip` called on them before they are inserted into the resulting CSV.

## Skipping headers

And what if we don't care about CSV headers? Just override `render_headers?` to false. You can keep or remove the header argument passed to `column`. If it's helpful for readability, you can keep it and it will be ignored. Or if it's clear enough without it, toss them.

::: code-group
```ruby
class UserExport < ApplicationCSV
  def render_headers? = false

  def row_template(user)
    column(user.id)
    column(user.first_name)
    column(user.last_name)
    column(user.email)
  end
end

UserExport.new(users).call
```
```csv
1,Buster,Bluth,buster@example.com
2,Maeby,Fünke,maeby@example.com
```
:::

## Overriding `initialize`

We've been using the provided initializer so far, which just takes a collection that will respond to `each`. But you can override the initializer to take whatever you like, as long as you call `super(collection)` passing it the desired collection.

This allows you to do things like, accept additional configuration or context that will affect how the data gets rendered, or add a final sort to the items, or if you're in Rails possibly adding some `includes` calls to preload some needed associations.

Let's take a look at one example of adding the context of the current user's role to change the CSV output.

```ruby
class TeamMembersExport < ApplicationCSV
  def initialize(members, permission:)
    @permission = permission
    super(members)
  end

  def row_template(member)
    column("first_name", member.first_name)
    column("last_name", member.last_name)
    column("email", member.email)

    if @permission == :supervisor
      column("hours_worked", member.hours_worked)
    end
  end
end
```

## Overriding `yielder`

One of the more powerful changes you can make is by redefining `yielder` which is what defines _what_ your `row_template` method gets called with.

Lets imagine we want an export of invoices, and invoices have many line items. We actually want each row to be a line item. We could map invoices into line items, and make sure that they're ordered properly so that line items from the same invoice are next to each other. Or we could keep our interface to the export as matching how we think about it: an export of invoices. And we can modify the `yielder`.

```ruby
class InvoiceExport < ApplicationCSV
  def yielder(invoice)
    invoice.line_items.each do |line_item|
      yield invoice, line_item
    end
  end

  def row_template(invoice, line_item)
    column("invoice_number", invoice.number)
    column("sku", line_item.sku)
    column("name", line_item.name)
    column("quantity", line_item.quantity)
    column("unit_cost", line_item.unit_cost)
  end
end

InvoiceExport.new(Invoice.last(5)).call
```

The `yield` inside our `yielder` method is what will ultimately call our `row_template`, passing in whatever has been yielded. We've taken advantage of that to do two things: we're `yield`ing multiple times per invoice, so that one invoice can turn into multiple lines in our CSV; and we're changing the signature of `row_template` so that instead of just getting an invoice passed in, we're getting both the invoice and line item.

## Overriding `each_item`

This is a really deep, in-the-weeds, overridable method. But if you need to change _how_ a collection is iterated, you can redefine `each_item`.

By default this is just defined as:

```ruby
def each_item(&)
  collection.each(&) # collection is the object passed to initialize
end
```

But if you're using `phlex-rails`, then we have a more memory friendly implementation that is aware of `ActiveRecord::Relation` objects and uses `find_each` if applicable[^find-each].

## Restrictions

You may have been wondering what happens if you change the order of the `columns`, or the values for the headers, or even the total number of columns, mid CSV.

For instance, what would this produce?

```ruby
class ChaosCSV < ApplicationCSV
  def row_template(record)
    if rand < 0.5
      column("heads", true)
    else
      column("tails", true)
    end
  end
end
```

Well, if you had more than one record, and they weren't all heads or all tails, then you would get a runtime error with an `Inconsistent header` message.

The first time `row_template` is called, `Phlex::CSV` stores all the headers it saw in an array. And on each subsequent call, the header value passed is checked against the stored header value at the same index.

This means you cannot change the order, or the amount of columns in the middle of a CSV. In [an above example](#custom-initializer) we did put a column in a conditional branch, but the condition came from a "global" configuration passed to initialize that will evaluate the same for all rows of that CSV.

[^find-each]: If the collection is a `ActiveRecord::Relation` _and_ it has no defined ordering, then `find_each` can safely be called on it. `find_each` requires control of the ordering and by default will override any already set order. So to preserve the order you've already set, we fallback to the default `each` iterator if you have an order defined.
