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
      log.section('Raise unexpected exception') do
        numerator = 1
        denominator = 0
        puts numerator / denominator
      end
    end
  end

end
```

Notes:

-
##  Test Log

<code>test_exception.xml</code>
```xml
<exception_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='exception_test' timestamp='2017-09-23-Sat-12.29.36.280'>
    <section duration_seconds='0.002' name='With ExampleRestClient'>
      <section name='Raise unexpected exception'>
        <uncaught_exception>
          <verdict_id>With ExampleRestClient</verdict_id>
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
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>1</act_value>
        <exception>
          <class>Minitest::Assertion</class>
          <message>Expected: 0 Actual: 1</message>
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

-

[Prev](./VolatilityTest.md) 
