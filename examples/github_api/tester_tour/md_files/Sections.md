<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Verdicts](./Verdicts.md#verdicts)


# Test Sections and Nesting

## Example Test

<code>sections_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SectionsTest < BaseClassForTest

  def test_sections
    prelude do |_, log|
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
  <test_method duration_seconds='6.010' name='sections_test' timestamp='2017-10-15-Sun-18.11.09.191'>
    <section name='With GithubClient'>
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
      <section name='Section with timestamp' timestamp='2017-10-15-Sun-18.11.09.191'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='1.008' name='Section with timestamp'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='2.000' name='Section with timestamp and duration' timestamp='2017-10-15-Sun-18.11.10.200'>
        <comment>Some test code can go here</comment>
      </section>
      <section duration_seconds='3.000' name='Order does not matter' timestamp='2017-10-15-Sun-18.11.12.200'>
        <comment>Some test code can go here</comment>
      </section>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
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

