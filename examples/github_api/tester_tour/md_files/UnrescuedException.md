<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Rescued Exception](./RescuedException.md#rescued-exception)

**Next Stop:** [Data Objects](./DataObjects.md#data-objects)


# Unrescued Exception

For an exception that is not rescued via `:rescue`, the log itself acts, by rescuing and logging the exception and its details.

## Example Test

<code>unrescued_exception_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class UnrescuedExceptionTest < BaseClassForTest

  def test_unrescued_exception
    prelude do |_, log|
      log.section('Unrescued exception') do
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

- Section `Exception not rescued` does not rescue its exception.  The test exits entirely, and any following code in the test is not reached.

## Log

<code>test_unrescued_exception.xml</code>
```xml
<unrescued_exception_test>
  <summary errors='1' failures='1' verdicts='1'/>
  <test_method name='unrescued_exception_test' timestamp='2017-10-23-Mon-05.13.20.910'>
    <section duration_seconds='0.002' name='With GithubClient'>
      <section name='Unrescued exception'>
        <uncaught_exception>
          <verdict_id>With GithubClient</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/unrescued_exception_test.rb:10:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/unrescued_exception_test.rb:10:in `block (2 levels) in test_unrescued_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/unrescued_exception_test.rb:7:in `block in test_unrescued_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/unrescued_exception_test.rb:6:in `test_unrescued_exception']]>
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
            <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/unrescued_exception_test.rb:6:in `test_unrescued_exception']]>
          </backtrace>
        </exception>
      </verdict>
    </section>
  </test_method>
</unrescued_exception_test>
```

Notes:

- The unrescued exception actually is rescued after all, by the log itself.  And of course it's logged.

**Prev Stop:** [Rescued Exception](./RescuedException.md#rescued-exception)

**Next Stop:** [Data Objects](./DataObjects.md#data-objects)

