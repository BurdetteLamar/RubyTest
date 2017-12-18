<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# Second Test

Here's a simple second test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>second_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

class SecondTest < BaseClassForTest

  def test_second
    prelude do |log|
      with_ui_client(log) do |ui_client|
        ui_client.login
      end
    end
  end

end
```

Notes:

- The test second defines:
  - `label_to_create`, a variable to  house data for creating a label.
  - `label_created`, a variable that will house the data for the created label, including new values for `:id` and `:url`.
- In section `Create`:
  - `create!`, a method that second deletes the label if it exists, then creates the label.  (Method `:create`, without the exclamation point, would fail if the label exists.)
  - `:create_return_correct` and `:created_correctly`, symbols that are _verdict identifiers_.  A verdict identifier appears in each verdict method call.
  - `Label.verdict_equal?`,  a method that verifies that the returned label data is correct.
  - `label_returned.verdict_read_and_verify?`, a method that verifies that the label was correctly created in GitHub.
  - `label_created`, a variable that saves the label data for use in the following sections.
- Inn section `Read`:
  - `Label.verdict_equal?`, a method that verifies that the returned label data is correct.
- Inn section `Update`:
  - `Label.verdict_equal?`, a method that verifies that the returned label data is correct.
  - `label_returned.verdict_read_and_verify?`, a method that verifies that the label was correctly updated in GitHub.
- In section `Delete`:
  - `log.verdict_assert_nil?`, a method that verifies that the return value is `nil`.
  - `label_created.verdict_refute_exist?`, a method that verifies that the label was deleted in GitHub.

## Log

You're welcome to review this log, but the smaller logs in other tour stops will introduce log features step by step.

<code>test_second.xml</code>
```xml
<second_test>
  <summary errors='0' failures='0' verdicts='1'/>
  <test_method duration_seconds='5.111' name='second_test' timestamp='2017-12-18-Mon-11.32.09.776'>
    <section name='Test'/>
  </test_method>
  <section name='Count of errors (unexpected exceptions)'>
    <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
      <exp_value>0</exp_value>
      <act_value>0</act_value>
    </verdict>
  </section>
</second_test>
```

**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

