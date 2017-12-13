<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Verdicts](./Verdicts.md#verdicts)

**Next Stop:** [Unrescued Exception](./UnrescuedException.md#unrescued-exception)


# Rescued Exception

A test (actually, each test section) determines what happens when an unexpected exception is raised.

It does so by making selected sections 'rescuable'.

## Example Test

<code>rescued_exception_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class RescuedExceptionTest < BaseClassForTest

  def test_rescued_exception
    prelude do |log, _|
      log.section('Rescued exception', :rescue) do
        numerator = 1
        denominator = 0
        quotient = numerator / denominator
        log.section('This section is not reached because of the exception') do
          log.verdict_assert?(:not_reached, quotient)
        end
      end
      log.section('This section is reached because the above exception was rescued') do
        log.verdict_assert?(:reached, true)
      end
    end
  end

end
```

Notes:

- Use optional argument `:rescue` in a `log.section` that should rescue an exception.
- Section `Exception rescued` rescues its exception.  The test exits the _section_, and any following code _in that section_ is not reached.
- Execution continues at the code following the rescued section.
- Any section, including a nested section, may rescue an exception.  (Or not -- it's an independent choice for each section.)

## Log

<code>test_rescued_exception.xml</code>
```xml
<rescued_exception_test>
  <summary errors='1' failures='1' verdicts='2'/>
  <test_method duration_seconds='0.000' name='rescued_exception_test' timestamp='2017-12-11-Mon-15.03.56.733'>
    <section name='Test'>
      <section name='Rescued exception'>
        <uncaught_exception>
          <verdict_id>Rescued exception</verdict_id>
          <class>ZeroDivisionError</class>
          <message>divided by 0</message>
          <backtrace>
            <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/rescued_exception_test.rb:10:in `/'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/rescued_exception_test.rb:10:in `block (2 levels) in test_rescued_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/rescued_exception_test.rb:7:in `block in test_rescued_exception'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (3 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/api/api_client.rb:19:in `with'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:19:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/rescued_exception_test.rb:6:in `test_rescued_exception']]>
          </backtrace>
        </uncaught_exception>
      </section>
      <section name='This section is reached because the above exception was rescued'>
        <verdict id='reached' method='verdict_assert?' outcome='passed' volatile='false'>
          <act_value>true</act_value>
        </verdict>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='failed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>1</act_value>
      <exception>
        <class>Minitest::Assertion</class>
        <message>Expected: 0 Actual: 1</message>
        <backtrace>
          <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:11:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/rescued_exception_test.rb:6:in `test_rescued_exception']]>
        </backtrace>
      </exception>
    </verdict>
  </section>
</rescued_exception_test>
```

Notes:

- The logged exception includes its message and backtrace.
- The last section in the log, named `Count of errors (unexpected exceptions)` has a verdict that expects that count to be 0.
- Because of the exception, that count is 1, and the verdict fails.

**Prev Stop:** [Verdicts](./Verdicts.md#verdicts)

**Next Stop:** [Unrescued Exception](./UnrescuedException.md#unrescued-exception)

