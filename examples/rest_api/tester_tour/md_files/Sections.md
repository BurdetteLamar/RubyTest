<!--- GENERATED FILE, DO NOT EDIT --->
**Prev** [Simple Test](./Test.md)

**Next** [Verdicts](./Verdicts.md)


# Sections and Nesting

This page shows test sections, including nesting, timestamps, and durations.

## Example Test

<code>sections_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SectionsTest < BaseClassForTest

  def test_sections
    prelude do |_, log|
      log.section('First outer section') do
        log.section('First inner section') do
          # Some test code here.
        end
        log.section('Second inner section') do
          # Some test code here.
        end
      end
      log.section('Second outer section') do
        # Some test code here.
      end
      log.section('Section with timestamp', :timestamp) do
        # Some test code here.
      end
      log.section('Section with timestamp', :duration) do
        sleep 1
      end
      log.section('Section with timestamp and duration', :timestamp, :duration) do
        sleep 1
      end
      log.section('Order does not matter', :duration, :timestamp) do
        sleep 1
      end
    end
  end

end
```

Notes:

- Use nested sections to organize test code.
- (This test does not use the client, and so by Ruby convention uses the variable name `_` instead of variable name `client`.)

## Log

<code>test_sections.xml</code>
```xml
<sections_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.023' name='sections_test' timestamp='2017-09-29-Fri-13.24.36.348'>
    <section name='With ExampleRestClient'>
      <section name='First outer section'>
        <section name='First inner section'/>
        <section name='Second inner section'/>
      </section>
      <section name='Second outer section'/>
      <section name='Section with timestamp' timestamp='2017-09-29-Fri-13.24.36.350'/>
      <section duration_seconds='1.009' name='Section with timestamp'/>
      <section duration_seconds='1.009' name='Section with timestamp and duration' timestamp='2017-09-29-Fri-13.24.37.359'/>
      <section duration_seconds='1.004' name='Order does not matter' timestamp='2017-09-29-Fri-13.24.38.368'/>
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

**Prev** [Simple Test](./Test.md)

**Next** [Verdicts](./Verdicts.md)

