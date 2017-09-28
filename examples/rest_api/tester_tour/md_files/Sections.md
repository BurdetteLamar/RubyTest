<!--- GENERATED FILE, DO NOT EDIT --->
**Prev** [The Simplest Test](./Test.md)

**Next** [Verdicts](./Verdicts.md)


# Sections and Nesting

This page introduces sections, including nesting, timestamps, and durations.

## Test Source Code

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
- This test does not use the client, and so uses the variable name <code>_</code> instead of variable name <code>client</code>.  This prevents the RubyMine IDE from flagging it as an unused variable during code inspection.

##  Test Log

<code>test_sections.xml</code>
```xml
<sections_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='3.004' name='sections_test' timestamp='2017-09-28-Thu-15.39.36.575'>
    <section name='With ExampleRestClient'>
      <section name='First outer section'>
        <section name='First inner section'/>
        <section name='Second inner section'/>
      </section>
      <section name='Second outer section'/>
      <section name='Section with timestamp' timestamp='2017-09-28-Thu-15.39.36.576'/>
      <section duration_seconds='1.001' name='Section with timestamp'/>
      <section duration_seconds='1.000' name='Section with timestamp and duration' timestamp='2017-09-28-Thu-15.39.37.577'/>
      <section duration_seconds='1.000' name='Order does not matter' timestamp='2017-09-28-Thu-15.39.38.577'/>
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

- The sections in the test are propagated to the log, so that both test and log have the same structure.

**Prev** [The Simplest Test](./Test.md)

**Next** [Verdicts](./Verdicts.md)

