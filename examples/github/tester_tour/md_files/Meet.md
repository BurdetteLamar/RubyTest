<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Overview](./Overview.md#overview)

**Next Stop:** [First Test](./First.md#first-test)


# Meet the Log and Clients

The test framework sets up for the test by delivering objects the test will need:

- An open test log.
- A domain-specific GitHub API client.
- A domain-specific GitHub UI client.

## Example Test

<code>meet_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class MeetTest < BaseClassForTest

  def test_meet
    prelude do |log|
      log.comment('Method prelude yields an instance of %s, for logging the test.' % log.class.name)
      with_api_client(log) do |api_client|
        log.comment('Method with_api_client yields an instance of %s, for accessing the GitHub API' % api_client.class.name)
      end
      with_ui_client(log) do |ui_client|
        log.comment('Method with_ui_client yields an instance of %s, for accessing the GitHub UI.' % ui_client.class.name)
      end
    end
  end

end
```

Notes:

- Create a new test class by deriving from `BaseClassForTest`.
- Choose a test method-name that begins with `test`, which tells the test framework that it can be executed at test-time.
- Call methods inherited from the base class:
  - `prelude`:  yields a `Log` object.
  - `with_api_client`:  yields an `ApiClient` object.
  - `with_ui_client`:  yields a `UiClient` object.

## Log

<code>test_meet.xml</code>
```xml
<meet_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='0.000' name='meet_test' timestamp='2017-12-18-Mon-12.00.21.210'>
    <section name='Test'>
      <comment>Method prelude yields an instance of Log, for logging the test.</comment>
      <comment>
        Method with_api_client yields an instance of ApiClient, for accessing
        the GitHub API
      </comment>
      <comment>
        Method with_ui_client yields an instance of UiClient, for accessing the
        GitHub UI.
      </comment>
    </section>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</meet_test>
```

Notes:

- At the top of the log is a summary of the counts of verdicts, failures (failed verdicts), and errors (unexpected exceptions).
- Element `test_method` gives the test name, timestamp, and duration.
- The section named `Test` contains all logging from the test itself.
- The last section gives the count of errors (unexpected exceptions).  Its verdict expects that count to be 0.
- (Attribute `volatile`, seen in element `verdict`, has to do with the Changes Report, and is of no present interest.)

**Prev Stop:** [Overview](./Overview.md#overview)

**Next Stop:** [First Test](./First.md#first-test)

