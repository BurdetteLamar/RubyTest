# Unit Tests

(This page is about the testing for RubyTest itself -- unit testing -- not about using RubyTest to test other software.)

## Assertions, Not Verdicts

The unit tests use assertions (which halt the testing), not verdicts (which do not).

That's because the unit tests function as build-verification tests, which must pass before every merge.

## Log

The largest part of the testing here is for one class:  Log.

- LogTest

## Helpers

Tests for helper classes include:

- HashHelperTest
- SetHelperTest
- StringHelperTest
- ValuesHelperTest
