<!--- GENERATED FILE, DO NOT EDIT --->
 [Next](./VerdictsTest.md)

# NothingTest

This page introduces the test class, along with the REST API client and the test log.

## Test Source Code

<code>nothing_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class NothingTest < BaseClassForTest

  def test_nothing
    prelude do |client, log|
      # Citation of client and log keeps RubyMine inspection from complaining.
      client.class
      log.class
    end
  end

end
```

Notes:

- Test class <code>NothingTest</code> derives from class<code>BaseClassForTest</code>.
- Method name <code>test_nothing</code> begins with <code>test</code>, which tells the test framework that it is a test method and should be executed at test-time.
- Inherited method <code>prelude</code> yields:
  - The domain-specific client to be used for testing the REST API.
  - The already-open log to be used for documenting the test execution.

##  Test Log

<code>test_nothing.xml</code>
```xml
<nothing_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.001' name='nothing_test' timestamp='2017-09-23-Sat-12.53.48.144'>
    <section name='With ExampleRestClient'/>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</nothing_test>
```

Notes:

- Element <code>summary</code>:  counts of verdicts, failures (failed verdicts), and errors (unexpected exceptions).
- Element <code>test_method</code>:  logging for test steps and verdicts.  (This test did nothing, so there's not much here.)
- The last section gives the count of errors (unexpected exceptions).  Its verdict expects the count to be 0.

 [Next](./VerdictsTest.md)
