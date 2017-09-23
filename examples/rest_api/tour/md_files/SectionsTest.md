<!--- GENERATED FILE, DO NOT EDIT --->
[Prev](./NothingTest.md) [Next](./VerdictsTest.md)

# SectionsTest

This page introduces sections, including nesting, timestamps, and durations.

## Test Source Code

<code>sections_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SectionsTest < BaseClassForTest

  def test_sections
    prelude do |client, log|
      # Citing client keeps RubyMine code inspection from complaining.
      client.class
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

- Use nested sections to structure test steps.

##  Test Log

<code>test_sections.xml</code>
```xml
<sections_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.011' name='sections_test' timestamp='2017-09-23-Sat-14.34.48.918'>
    <section name='With ExampleRestClient'>
      <section name='First outer section'>
        <section name='First inner section'/>
        <section name='Second inner section'/>
      </section>
      <section name='Second outer section'/>
      <section name='Section with timestamp' timestamp='2017-09-23-Sat-14.34.48.919'/>
      <section duration_seconds='1.000' name='Section with timestamp'/>
      <section duration_seconds='1.001' name='Section with timestamp and duration' timestamp='2017-09-23-Sat-14.34.49.920'/>
      <section duration_seconds='1.008' name='Order does not matter' timestamp='2017-09-23-Sat-14.34.50.920'/>
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

[Prev](./NothingTest.md) [Next](./VerdictsTest.md)

Notes:

- The sections in the test are propagated to the log, giving it the same structure.