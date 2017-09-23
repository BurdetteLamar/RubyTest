[Prev](c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/md_files/VerdictsTest.md) [Next](c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/md_files/ExceptionTest.md)

# VolatilityTest

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
    end
  end

end
```

Notes:

- The Changes Report (elsewhere in this project) evaluates a current test run's logs against those of the previous test run.
- Above:
  - The first verdict's values are non-volatile, expected to be the same in each test run.  If the value changed from the previous, the Changes Report would mark the verdict as changed.
  - The second verdict's values are volatile, changing with each test run.  The Changes Report will not mark the verdict as changed.

##  Test Log

<code>test_volatility.xml</code>
```xml
<volatility_test>
  <summary errors='0' failures='0' verdicts='3'/>
  <test_method duration_seconds='1.018' name='volatility_test' timestamp='2017-09-23-Sat-12.01.13.492'>
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

[Prev](c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/md_files/VerdictsTest.md) [Next](c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/md_files/ExceptionTest.md)
