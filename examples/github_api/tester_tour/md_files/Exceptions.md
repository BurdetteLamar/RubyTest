<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verdicts](./Verdicts.md)

**Next Stop:** [Logging a Simple Data Object](./DataLogSimple.md)


# Exceptions, Rescued and Not

This page introduces the handling of unexpected exceptions.

## Example Test

<code>exceptions_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class ExceptionsTest < BaseClassForTest

  def test_exceptions
    prelude do |_, log|
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

- The first outer section rescues its exception.  The test exits the _section_, and any following code in the _section_ is not reached.
- The second outer section does not rescue its exception.  The test exits entirely, and any following code in the _test_ is not reached.
- Any section, including a nested section, may rescue an exception.  (Or not -- it's an independent choice for each section.)

## Log

<code>test_exceptions.xml</code>
```xml
<exceptions_test>
  <summary errors='2' failures='1' verdicts='2'/>
  <test_method name='exceptions_test' timestamp='2017-10-10-Tue-19.05.23.238'>
    <section duration_seconds='0.010' name='With GithubClient'>
      <section name='Section rescues exception'>
        <uncaught_exception>
          <verdict_id>Section rescues exception</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:10:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:10:in `block (2 levels) in test_exceptions'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:7:in `block in test_exceptions'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:6:in `test_exceptions']]>
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
          <verdict_id>With GithubClient</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:21:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:21:in `block (2 levels) in test_exceptions'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:18:in `block in test_exceptions'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:13:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:18:in `block in with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/github_client.rb:14:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:12:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:6:in `test_exceptions']]>
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
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github_api/tester_tour/tests/exceptions_test.rb:6:in `test_exceptions']]>
          </backtrace>
        </exception>
      </verdict>
    </section>
  </test_method>
</exceptions_test>
```

Notes:

- Each logged exception includes its message and backtrace.
- The second exception, the one the test didn't rescue, is actually rescued by the log itself, and of course logged.

**Prev Stop:** [Verdicts](./Verdicts.md)

**Next Stop:** [Logging a Simple Data Object](./DataLogSimple.md)
