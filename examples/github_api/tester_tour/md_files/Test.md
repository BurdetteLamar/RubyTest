<!--- GENERATED FILE, DO NOT EDIT --->
**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# Simple Test

## Example Test

<code>test_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SimpleTest < BaseClassForTest

  def test_test
    prelude do |client, log|
      log.comment('Test code goes here')
      log.comment('Method prelude yields two objects:')
      log.comment('1. Instance of %s, for access to the GitHub API.' % client.class.name)
      log.comment('2. Instance of %s, for logging the test.' % log.class.name)
    end
  end

end
```

Notes:

- Create a new test class by deriving from `BaseClassForTest`.
- Choose a test method-name that begins with `test`, which tells the test framework that it can be executed at test-time.
- Call method `prelude`, inherited from the base class.
- Use the yielded values for your test.
  - A domain-specific GitHub API client.
  - An open test log.

## Log

<code>test_test.xml</code>
```xml
<test_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.003' name='test_test' timestamp='2017-10-15-Sun-16.20.47.778'>
    <section name='With GithubClient'>
      <comment>Test code goes here</comment>
      <comment>Method prelude yields two objects:</comment>
      <comment>1. Instance of GithubClient, for access to the GitHub API.</comment>
      <comment>2. Instance of Log, for logging the test.</comment>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</test_test>
```

Notes:

- At the top of the log is a summary of the counts of verdicts, failures (failed verdicts), and errors (unexpected exceptions).
- Element `test_method` gives the test name, timestamp, and duration.
- The section named `With GitHubClient` contains all logging from the test itself.
- The last section gives the count of errors (unexpected exceptions).  Its verdict expects that count to be 0.
- (Attribute `volatile`, seen in element `verdict`, has to do with the Changes Report, and is of no present interest.)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

