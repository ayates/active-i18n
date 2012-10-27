# ActiveI18n

ActiveI18n is a quick and dirty translation Gem which solves some issues I was having with the other popular options.

Primarily I don't want my users to have to change locale so they can edit the texts in another language, I don't want a translations table per model and I want to be able to add more languages at runtime.

## Requirements

* ActiveRecord > 3.2.0
* I18n

## Installation

```ruby
rails g active_i18n:migrations
```

## Usage

In models:

```ruby
class Product < ActiveRecord::Base
  translates :name, :description
end
```

In your forms you can use fields such as :name_en, :name_de, :name_es to access the individual translations

```ruby
- active_languages.each do |locale|
  = form.input :"name_#{locale}"
```

And in your views:

```ruby
I18n.locale = :en
@product.name # => English Name

I18n.locale = :de
@product.name # => German Name
```