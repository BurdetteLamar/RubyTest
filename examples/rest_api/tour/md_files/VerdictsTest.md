<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./SectionsTest.md) [Next](./VolatilityTest.md)

# VerdictsTest

## Test Source Code

This page introduces verdicts.

<code>verdicts_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |client, log|
      log.section('A verdict that should pass') do
        # Using extra variables here, to make usage clear.
        log.verdict_assert?(
            verdict_id = 'different',
            actual = client != log,
            message = 'The client and log are not equal'
        )
      end
      log.section('A verdict that should fail') do
        log.verdict_refute?(
            verdict_id = 'same',
            actual = client != log,
            message = 'The client and log are equal'
        )
      end
    end
  end

end
```

Notes:

- Use sections to organize the test steps;  sections can nest.
- Each verdict has:
  - A verdict identifier, which must be unique within the test.
  - A message string.
- Use an assert verdict to express a positive expectation.
- Use a refute verdict to express a negative expectation.


##  Test Log

<code>test_verdicts.xml</code>
```xml
<verdicts_test>
  <summary errors='0' failures='1' verdicts='3'/>
  <test_method duration_seconds='0.003' name='verdicts_test' timestamp='2017-09-23-Sat-14.34.52.965'>
    <section name='With ExampleRestClient'>
      <section name='A verdict that should pass'>
        <verdict id='different' message='The client and log are not equal' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='A verdict that should fail'>
        <verdict id='same' message='The client and log are equal' method='verdict_refute?' outcome='failed' volatile='false'>
          <act_value>true</act_value>
          <exception>
            <class>Minitest::Assertion</class>
            <message>Expected true to not be truthy.</message>
            <backtrace>
              <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/verdicts_test.rb:16:in `block (2 levels) in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/verdicts_test.rb:15:in `block in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/verdicts_test.rb:6:in `test_verdicts']]>
            </backtrace>
          </exception>
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
</verdicts_test>
```

Notes:

- The failed verdict logs an exception, including the message and backtrace.

[Prev](./SectionsTest.md) [Next](./VolatilityTest.md)