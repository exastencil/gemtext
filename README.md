# Gemtext

This gem provides data structures and parsing capabilities for
[gemtext](https://gemini.circumlunar.space/docs/specification.html)
(text/gemini). Gemtext is pretty simple, so this is just meant to save
you some work.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemtext'
```

And then execute:

    bundle install

Or install it yourself as:

    gem install gemtext

## Usage

```ruby
Gemtext.parse(io)
#=> <#Gemtext::Document>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/exastencil/gemtext>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/exastencil/gemtext/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gemtext project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/exastencil/gemtext/blob/master/CODE_OF_CONDUCT.md).
