# NothingTest

## Test Source Code

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

- Test class <code>NothingTest</code> derives from class<code>BaseClassForTest</code>.
- Test method <code>test_nothing</code> begins with <code>test</code>, which tells the test framework that it is a test method and should be executed at test-time.
- Inherited method <code>prelude</code> yields:
  - The domain-specific client to be used for testing the REST API.
  - The already-open log to be used for documenting the test execution.

##  Test Log

```xml
<nothing_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.000' name='nothing_test' timestamp='2017-09-20-Wed-16.04.50.087'>
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

## Under the Hood

### Base Class for Test

```ruby
require 'minitest/autorun'

require_relative '../../../lib/helpers/test_helper'
require_relative '../example_rest_client'

class BaseClassForTest < Minitest::Test

  def prelude
    raise 'No block given' unless (block_given?)
    log_dir_path = TestHelper.get_app_log_dir_path('rest_api')
    TestHelper.test(self, log_dir_path) do |log|
      ExampleRestClient.with(log) do |client|
        yield client, log
      end
    end
  end

end

```


