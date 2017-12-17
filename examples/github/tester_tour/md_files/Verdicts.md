<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

**Next Stop:** [Rescued Exception](./RescuedException.md#rescued-exception)


# Verdicts

Verifications are the heart of a test -- indeed, its purpose.

The framework offers robust support for logging verifications, via its `verdict` methods.

## Example Test

<code>verdicts_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class VerdictsTest < BaseClassForTest

  def test_verdicts
    prelude do |log, _|
      # Using extra variables in these verdicts, to make usage clear.
      log.section('These verdicts should pass') do
        log.section('An assert verdict that should pass') do
          log.verdict_assert?(
              verdict_id = :assert_should_pass,
              actual = true,
          )
        end
        log.section('A refute verdict that should pass') do
          log.verdict_refute?(
              verdict_id = :refute_should_pass,
              actual = false,
          )
        end
      end
      log.section('These verdicts should fail') do
        log.section('An assert verdict that should fail') do
          log.verdict_assert?(
              verdict_id = :assert_should_fail,
              actual = false,
          )
        end
        log.section('A refute verdict that should fail') do
          log.verdict_refute?(
              verdict_id = :refute_should_fail,
              actual = true,
          )
        end
      end
    end
  end

end
```

Notes:

- Use `verdict` methods for verifications.
- A call to a verdict method will have:
  - A verdict identifier, which must be unique within the test.
  - Other parameters, as appropriate to the particular method.
  - A message string.
- An `assert` verdict expects something to be truthy (not `false` or `nil`).
- A `refute` verdict expects something to be `false` or `nil`.
- There are many other verdict methods, some of which will be described later in this tour.
- A verdict method returns a boolean value, and therefore follows the Ruby convention of ending the method name with `?`.


## Log

<code>test_verdicts.xml</code>
```xml
<verdicts_test>
  <summary errors='0' failures='2' verdicts='5'/>
  <test_method duration_seconds='0.016' name='verdicts_test' timestamp='2017-12-17-Sun-14.09.21.266'>
    <section name='Test'>
      <section name='These verdicts should pass'>
        <section name='An assert verdict that should pass'>
          <verdict id='assert_should_pass' method='verdict_assert?' outcome='passed' volatile='false'>
            <act_value>true</act_value>
          </verdict>
        </section>
        <section name='A refute verdict that should pass'>
          <verdict id='refute_should_pass' method='verdict_refute?' outcome='passed' volatile='false'>
            <act_value>false</act_value>
          </verdict>
        </section>
      </section>
      <section name='These verdicts should fail'>
        <section name='An assert verdict that should fail'>
          <verdict id='assert_should_fail' method='verdict_assert?' outcome='failed' volatile='false'>
            <act_value>false</act_value>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected false to be truthy.</message>
              <backtrace>
                <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:24:in `block (3 levels) in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:23:in `block (2 levels) in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:22:in `block in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:6:in `test_verdicts']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
        <section name='A refute verdict that should fail'>
          <verdict id='refute_should_fail' method='verdict_refute?' outcome='failed' volatile='false'>
            <act_value>true</act_value>
            <exception>
              <class>Minitest::Assertion</class>
              <message>Expected true to not be truthy.</message>
              <backtrace>
                <![CDATA[
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:30:in `block (3 levels) in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:29:in `block (2 levels) in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:22:in `block in test_verdicts'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:21:in `block (2 levels) in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:20:in `block in prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:23:in `block (2 levels) in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:22:in `block in test'
c:/Users/Burdette/Documents/GitHub/RubyTest/lib/helpers/test_helper.rb:21:in `test'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/base_classes/base_class_for_test.rb:12:in `prelude'
c:/Users/Burdette/Documents/GitHub/RubyTest/examples/github/tester_tour/tests/verdicts_test.rb:6:in `test_verdicts']]>
              </backtrace>
            </exception>
          </verdict>
        </section>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</verdicts_test>
```

Notes:

- Every verdict is fully logged.
- A failed verdict logs its backtrace.

**Prev Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

**Next Stop:** [Rescued Exception](./RescuedException.md#rescued-exception)

