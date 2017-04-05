# Test

## Assertions, Not Verdicts

The testing here uses assertions (which halt the testing), not verdicts (which do not).

That's because the tests are not regression tests, but instead are build-verification tests, which must pass before every merge.

## Log

The largest part of the testing here is for one class:  Log.

- LogTest

## Helpers

Tests for helper classes include:

- HashHelperTest
- SetHelperTest
- StringHelperTest
- ValuesHelperTest
