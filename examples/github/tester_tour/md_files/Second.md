<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [First Test](./First.md#first-test)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# Second Test

Here's a simple second test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>second_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../data/label'

require_relative '../../ui/pages/labels_page'

class SecondTest < BaseClassForTest

  def test_second

    prelude do |log|

      with_ui_client(log) do |ui_client|

        ui_client.login
        labels_page = LabelsPage.new(ui_client).visit
        label_to_create = nil

        log.section('Create label') do
          label_to_create = Label.provisioned
          # Boolean value for field :default is not available in the UI.
          label_to_create.default = nil
          labels_page.create_label!(label_to_create)
          labels_page.wait_for_label(label_to_create)
          labels_page.verdict_assert_exist?(log, :label_created, label_to_create)
        end

        log.section('Read label') do
          label_to_read = label_to_create
          label_read = labels_page.read_label(label_to_read)
          labels_page.wait_for_label(label_to_read)
          Label.verdict_equal?(log, :label_created, label_to_read, label_read)
        end

        label_source = nil
        log.section('Update label') do
          label_source = label_to_create.perturb
          # Boolean value for field :default is not available in the UI.
          label_source.default = nil
          labels_page.update_label!(label_to_create, label_source)
          labels_page.wait_for_label(label_source)
          labels_page.verdict_assert_exist?(log, :label_updated, label_source)
        end

        log.section('Delete label') do
          label_to_delete = label_source
          labels_page.delete_label(label_to_delete)
          ui_client.browser.refresh
          labels_page.verdict_refute_exist?(log, :label_deleted, label_to_delete)
        end

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
  <summary errors='0' failures='0' verdicts='10'/>
  <test_method duration_seconds='28.566' name='second_test' timestamp='2017-12-22-Fri-18.05.06.829'>
    <section name='Test'>
      <section name='Create label'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
          <execution duration_seconds='3.855' timestamp='2017-12-22-Fri-18.05.13.753'/>
        </ApiClient>
        <verdict id='label_created:exist' method='verdict_assert_includes?' outcome='passed' volatile='false'>
          <exp_value>
            [&quot;test label&quot;, &quot;bug&quot;, &quot;duplicate&quot;,
            &quot;enhancement&quot;, &quot;good first issue&quot;, &quot;help
            wanted&quot;, &quot;invalid&quot;, &quot;question&quot;]
          </exp_value>
          <act_value>test label</act_value>
        </verdict>
        <section class='Label' method='verdict_equal?' name='equal'>
          <verdict id='label_created:equal:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>test label</exp_value>
            <act_value>test label</act_value>
          </verdict>
          <verdict id='label_created:equal:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>000000</exp_value>
            <act_value>000000</act_value>
          </verdict>
        </section>
      </section>
      <section name='Read label'>
        <section class='Label' method='verdict_equal?' name='label_created'>
          <verdict id='label_created:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>test label</exp_value>
            <act_value>test label</act_value>
          </verdict>
          <verdict id='label_created:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>000000</exp_value>
            <act_value>000000</act_value>
          </verdict>
        </section>
      </section>
      <section name='Update label'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/not%20test%20label'>
          <execution duration_seconds='0.321' timestamp='2017-12-22-Fri-18.05.27.951'/>
        </ApiClient>
        <verdict id='label_updated:exist' method='verdict_assert_includes?' outcome='passed' volatile='false'>
          <exp_value>
            [&quot;bug&quot;, &quot;duplicate&quot;, &quot;enhancement&quot;,
            &quot;good first issue&quot;, &quot;help wanted&quot;,
            &quot;invalid&quot;, &quot;question&quot;, &quot;not test
            label&quot;]
          </exp_value>
          <act_value>not test label</act_value>
        </verdict>
        <section class='Label' method='verdict_equal?' name='equal'>
          <verdict id='label_updated:equal:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>not test label</exp_value>
            <act_value>not test label</act_value>
          </verdict>
          <verdict id='label_updated:equal:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>ffffff</exp_value>
            <act_value>ffffff</act_value>
          </verdict>
        </section>
      </section>
      <section name='Delete label'>
        <verdict id='label_deleted' method='verdict_refute_includes?' outcome='passed' volatile='false'>
          <exp_value>
            [&quot;bug&quot;, &quot;duplicate&quot;, &quot;enhancement&quot;,
            &quot;good first issue&quot;, &quot;help wanted&quot;,
            &quot;invalid&quot;, &quot;question&quot;]
          </exp_value>
          <act_value>not test label</act_value>
        </verdict>
      </section>
    </section>
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

