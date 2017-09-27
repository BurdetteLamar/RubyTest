<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./Verdicts.md) [Next](./Exceptions.md)

# Volatile Return Values

This page introduces verdict volatility.

The Changes Report (elsewhere in this project) identifies changes found in comparing the results of the current and previous test runs.

If a verdict's actual value is different in the two runs, the change would be reported.

There are cases, though, when this would be inappropriate.

Suppose a request creates an object (say, a new user) whose identifier is a new GUID.  Then the identifier will be different in every test run, and by default the Changes Report would note the change, even though the change is actually expected.

Marking a verdict as <code>volatile</code> handles this case.  For a volatile verdict, the Changes Report will ignore the differing values, which is what's wanted.

## Test Source Code

<code>volatility_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class VolatilityTest < BaseClassForTest

  def test_volatility
    prelude do |client, log|
      log.section('Non-volatile value') do
        log.verdict_assert?('positive', Math.cos(0) > 0, 'Cos(0) positive')
      end
      log.section('Volatile value') do
        earlier = Time.now
        sleep 1
        later = Time.now
        log.verdict_assert?('sequence', earlier < later, 'Time order', volatile = true)
      end
      # Citing client keeps RubyMine code inspection from complaining
      # about the unused variable.
      client.class
    end
  end

end
```

Notes:

- The first verdict's values are non-volatile, expected to be the same in each test run.  If the value changed from the previous, the Changes Report would mark the verdict as changed.
- The second verdict's values are volatile, changing with each test run.  The Changes Report will not mark the verdict as changed.

##  Test Log

<code>test_volatility.xml</code>
```xml
<volatility_test>
  <summary errors='0' failures='0' verdicts='3'/>
  <test_method duration_seconds='1.002' name='volatility_test' timestamp='2017-09-27-Wed-15.01.19.660'>
    <section name='With ExampleRestClient'>
      <section name='Non-volatile value'>
        <verdict id='positive' message='Cos(0) positive' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='Volatile value'>
        <verdict id='sequence' message='Time order' method='verdict_assert?' outcome='passed' volatile='true'>
          <act_value>true</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</volatility_test>
```

[Prev](./Verdicts.md) [Next](./Exceptions.md)
