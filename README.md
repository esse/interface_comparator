# InterfaceComparator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interface_comparator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install interface_comparator

## Usage

```ruby
require 'interface_comparator'
# check if two objects has the same interface
# including public methods list and their arity
InterfaceComparator.same?(a, b) # => true or false

# see detailed list of difference between interfaces
# of two objects
InterfaceComparator.diff_interfaces(a, b)
# if there are difference between methods
# it will return them in aa array of hashes:
#[{
#    method: :new_method,
#    first_object: true,
#    second_object: false
#}]
#
# if there are not difference between methods
# but there are differences in arity of them
# it will return them in an array of hashes:
#[{
#    method: :new_method,
#    first_object_arity: 1,
#    second_object_arity: 0
#}]
```

## Usage with minitest

If you want to use it with minitest, please require helper:
```ruby
require 'interface_comparator/minitest'
```

Library will provide you with two new assertions:
```ruby
assert_equal_interfaces a, b
refute_equal_interfaces a, b
```

Output in case of failure will be similar to those in diff_interfaces.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/esse/interface_comparator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InterfaceComparator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/interface_comparator/blob/master/CODE_OF_CONDUCT.md).
