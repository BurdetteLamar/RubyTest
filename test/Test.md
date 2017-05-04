# Unit Tests

(This page is about the testing for RubyTest itself -- unit testing -- not about using RubyTest to test other software.)

## Assertions, Not Verdicts

The unit tests use assertions (which halt the testing), not verdicts (which do not).

That's because the unit tests function as build-verification tests, which must pass before every merge.

## Log

The largest part of the testing here is for one class:  Log.

- [log_test.rb](./log_test.rb)

## Helpers

Tests for helper classes include:

- [hash_helper_test.rb](./helpers/hash_helper_test.rb)
- [set_helper_test.rb](./helpers/set_helper_test.rb)
- [string_helper_test.rb](./helpers/string_helper_test.rb)
- [values_helper_test.rb](./helpers/values_helper_test.rb)
