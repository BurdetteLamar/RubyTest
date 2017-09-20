# NothingTest

## Source Code

```ruby
require_relative '../../base_classes/base_class_for_test'

class NothingTest < BaseClassForTest

  def test_nothing

    prelude do |client, log|

      # Test code goes here.

    end

  end

end
```

### Notes

- The test class derives from class<code>BaseClassForTest</code>.
- The test method <code>test_nothing</code> begins with <code>test</code>, which tells the test framework that it is a test method and should be executed at test-time.
- Inherited method <code>prelude</code> yields:
  - The domain-specific client to be used for testing the REST API.
  - The already-open log to be used for documenting the test execution.

##  Test Log

```xml
<nothing_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.000' name='nothing_test' timestamp='2017-09-20-Wed-15.08.40.282'>
    <section name='With ExampleRestClient'/>
  </test_method>
  <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
    <exp_value>0</exp_value>
    <act_value>0</act_value>
  </verdict>
</nothing_test>
```

### Notes

Elements:

- <code>summary</code>:  counts of verdicts, failures (failed verdicts), and errors (unexpected exceptions).
- <code>test_method</code>:  logging for test steps and verdicts.  (This test did nothing, so there's not much here.)
- <code>verdict</code>:  Expected no errors (unexpected exceptions), got none.

