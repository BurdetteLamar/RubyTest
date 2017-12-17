<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Verdicts](./Verdicts.md#verdicts)


# Test Sections and Nesting

A test and its log have many duties, but one of the first is their duty to tell a story.

Reading the test code or the log, you should be able to understand how the test is organized, and what it's trying to do.  Nested sections help with that.

## Example Test

<code>sections_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SectionsTest < BaseClassForTest

  def test_sections
    prelude do |log, _|
      log.section('First outer section') do
        log.section('First inner section') do
          log.comment('Some test code can go here')
        end
        log.section('Second inner section') do
          log.comment('Some test code can go here')
        end
      end
      log.section('Second outer section') do
        log.comment('Some test code can go here')
      end
      log.section('Section with timestamp', :timestamp) do
        log.comment('Some test code can go here')
      end
      log.section('Section with timestamp', :duration) do
        log.comment('Some test code can go here')
        sleep 1
      end
      log.section('Section with timestamp and duration', :timestamp, :duration) do
        log.comment('Some test code can go here')
        sleep 2
      end
      log.section('Order does not matter', :duration, :timestamp) do
        log.comment('Some test code can go here')
        sleep 3
      end
    end
  end

end
```

Notes:

- Use nested sections to organize test code.
- Use optional argument `:timestamp` to add a timestamp to the logged section.
- Use optional argument `:duration` to add an execution duration to the logged section.
- (This test does not use the client, and so by Ruby convention uses the variable name `_` instead of variable name `client`.)

## Log

<code>test_sections.xml</code>
```xml
<sections_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='6.053' name='sections_test' timestamp='2017-12-17-Sun-14.09.13.778'>
    <section name='Test'>
      <section name='First outer section'>
        <section name='First inner section'>
          <comment>Some test code can go here</comment>
        </section>
        <section name='Second inner section'>
          <comment>Some test code can go here</comment>
        </section>
      </section>
      <section name='Second outer section'>
        <comment>Some test code can go here</comment>
      </section>
      <section name='Section with timestamp' timestamp='2017-12-17-Sun-14.09.13.793'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='1.014' name='Section with timestamp'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='2.012' name='Section with timestamp and duration' timestamp='2017-12-17-Sun-14.09.14.807'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='3.011' name='Order does not matter' timestamp='2017-12-17-Sun-14.09.16.820'>
        <comment>Some test code can go here</comment>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</sections_test>
```

Notes:

- The sections in the test are propagated to the log, so that the log is organized the same way as the test.

**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Verdicts](./Verdicts.md#verdicts)

