<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./VolatilityTest.md) 

# ExceptionTest

This page introduces the handling of unexpected exceptions.

## Test Source Code

<code>exception_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class ExceptionTest < BaseClassForTest

  def test_exception
    prelude do |client, log|
      log.section('Section rescues exception', :rescue) do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?('first not reached', quotient, 'Did not make it her because exception raised')
        end
      end
      log.section('This section is reached because the above exception was rescued') do
        log.verdict_assert?('reached', true, 'Made it to here')
      end
      log.section('Section does not rescue exception') do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?('second not reached', quotient, 'Did not make it here because exception raised')
        end
      end
      log.section('This section is not reached because of the unrescued exception') do
        log.verdict_assert?('third not reached', true, 'Did not make it here because exception raised')
      end
    end
  end

end
```

Notes:

- The first outer section rescues its exception.  Following code in the **section** is not reached.
- The second outer section does not rescue its exception.  Following code in the **test** is not reached.

##  Test Log

<code>test_exception.xml</code>
```xml
<exception_test>
  <summary errors='2' failures='1' verdicts='2'/>
  <test_method name='exception_test' timestamp='2017-09-23-Sat-15.09.36.447'>
    <section duration_seconds='0.006' name='With ExampleRestClient'>
      <section name='Section rescues exception'>
        <uncaught_exception>
          <verdict_id>Section rescues exception</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:10:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:10:in `block (2 levels) in test_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:7:in `block in test_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:6:in `test_exception']]>
          </backtrace>
        </uncaught_exception>
      </section>
      <section name='This section is reached because the above exception was rescued'>
        <verdict id='reached' message='Made it to here' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
      <section name='Section does not rescue exception'>
        <uncaught_exception>
          <verdict_id>With ExampleRestClient</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:21:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:21:in `block (2 levels) in test_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:18:in `block in test_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/example_rest_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:6:in `test_exception']]>
          </backtrace>
        </uncaught_exception>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>2</act_value>
        <exception>
          <class>Minitest::Assertion</class>
          <message>Expected: 0 Actual: 2</message>
          <backtrace>
            <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/rest_api/tour/tests/exception_test.rb:6:in `test_exception']]>
          </backtrace>
        </exception>
      </verdict>
    </section>
  </test_method>
</exception_test>
```

Notes:

- Each logged exception includes its message and backtrace.
- The second exception, the one the test didn't rescue, is actually rescued by the log itself, and of course logged.

[Prev](./VolatilityTest.md) 
