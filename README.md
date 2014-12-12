# ATV: Ascii Table Values

ATV is a reader for data in ascii table format.
It allows you to read data formatted like this:

<pre>
|------------------+--------------------|
| name             | dob                |
|------------------+--------------------|
| Malcolm Reynolds | September 20, 2468 |
|------------------+--------------------|
| Zoe Washburne    | February 15, 2484  |
|------------------+--------------------|
</pre>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atv

## Usage

Rows are returned or yielded as [CSV::Row][1] objects.

<pre>
|-----------------------+------------------------------+-----------------------------------|
| **Ascii Table Value** | **Returned Value**           | **Notes**                         |
|-----------------------+------------------------------+-----------------------------------|
| Malcolm Reynolds      | "Malcolm Reynolds"           | Most values returned as string    |
|-----------------------+------------------------------+-----------------------------------|
| 123                   | "123"                        | including numbers                 |
|-----------------------+------------------------------+-----------------------------------|
| wrapped strings are   | "wrapped strings are folded" | Similar to yaml, wrapped          |
| folded                |                              | strings are folded with a single  |
|                       |                              | space replacing the new line      |
|-----------------------+------------------------------+-----------------------------------|
|                       | blank values are omitted     | The CSV::Row object will not      |
|                       |                              | include columns with blank values |
|-----------------------+------------------------------+-----------------------------------|
| null                  | nil                          | nil, true, and false are          |
|                       |                              | special values                    |
|-----------------------+------------------------------+-----------------------------------|
| true                  | true                         |                                   |
|-----------------------+------------------------------+-----------------------------------|
| false                 | false                        |                                   |
|-----------------------+------------------------------+-----------------------------------|
</pre>

**Reading a String**

```ruby
atv = ATV.from_string(string)
atv.each do |row|
  # use row here...
end
```

**Reading from am IO object**

```ruby
atv = ATV.new(io)
atv.each do |row|
  # use row here...
end
```

## Contributing

1. Fork it ( https://github.com/IndieKelly/atv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: http://www.ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV/Row.html
