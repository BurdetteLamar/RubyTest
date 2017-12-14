# RubyTest

It's all well and good to _write_ about testing software.  (Actually I _do_ write about it, over at [my blog](https://burdettelamar.wordpress.com/).)

But it's so much better to _show_ actual working code.  And that's what this project does.

It provides _working software_ to help with automated software testing.

The project consists of examples, the framework that supports them, and of course testing for the framework.

Links to the markdown documentation are at:

- [Contents](./Contents.md#contents-markdown-pages)

## Examples

An important example is about testing for the GitHub REST API.  Take the [Tester Tour](./examples/github/TesterTour.md#tester-tour).

## Framework

The testing is supported by

- [Robust logging](./lib/log/Log.md#log)
- [Helpers](./lib/helpers/Helpers.md#helpers)
- [Base classes](./lib/base_classes/BaseClasses.md#base-classes)

The framework itself is tested by

- [Unit testing](./test/Test.md#unit-tests)

There are also

- [Logging examples](./examples/log/Log.md#log-examples)

## Rake Tasks

You can also review all rake tasks by running command

- <code>rake -D</code>

or by visiting the documentation for the [Rakefile](./Rakefile.md#rakefile).

## RDoc

You can build the RDoc by cloning and running command

- <code>rake build:rerdoc</code>
  
The RDoc output will be in directory <code>html/</code>, with the index file at <code>html/index.html</html>.
