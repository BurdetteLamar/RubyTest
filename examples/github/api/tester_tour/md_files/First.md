<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [Meet the Client and Log](./Meet.md#meet-the-client-and-log)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)


# First Test

Here's a simple first test, one that tests CRUD methods (create, read, update, delete) to operate on `Label` objects.

## Example Test

<code>first_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../../data/label'

class FirstTest < BaseClassForTest

  def test_first

    prelude do |log, api_client|

      label_to_create = Label.provisioned
      label_created = nil

      log.section('Create') do
        label_returned = label_to_create.create!(api_client)
        Label.verdict_equal?(log, :create_return_correct, label_to_create, label_returned)
        label_returned.verdict_read_and_verify?(api_client, log, :created_correctly)
        label_created = label_returned
      end

      log.section('Read') do
        label_returned = label_created.read(api_client)
        Label.verdict_equal?(log, :read_correctly, label_created, label_returned)
      end

      log.section('Update') do
        label_to_update = label_created.perturb
        label_returned = label_to_update.update(api_client)
        label_to_update.log(log, 'Label to update')
        label_returned.log(log, 'Label returned')
        Label.verdict_equal?(log, :update_return_correct, label_to_update, label_returned)
        label_returned.verdict_read_and_verify?(api_client, log, :updated_correctly)
      end

      log.section('Delete') do
        label_returned = label_created.delete(api_client)
        log.verdict_assert_nil?(:delete_return_correct, label_returned)
        label_created.verdict_refute_exist?(api_client, log, :deleted_correctly)
      end

    end

  end

end
```

Notes:

- The test first defines:
  - `label_to_create`, a variable to  house data for creating a label.
  - `label_created`, a variable that will house the data for the created label, including new values for `:id` and `:url`.
- In section `Create`:
  - `create!`, a method that first deletes the label if it exists, then creates the label.  (Method `:create`, without the exclamation point, would fail if the label exists.)
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

<code>test_first.xml</code>
```xml
<first_test>
  <summary errors='0' failures='0' verdicts='26'/>
  <test_method name='first_test' timestamp='2017-12-09-Sat-15.16.18.615'>
    <section name='Test'>
      <section name='Create'>
        <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
          <execution duration_seconds='1.903' timestamp='2017-12-09-Sat-15.16.18.615'/>
        </ApiClient>
        <ApiClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <parameters color='000000' name='test label'/>
          <execution duration_seconds='0.359' timestamp='2017-12-09-Sat-15.16.20.519'/>
        </ApiClient>
        <section class='Label' method='verdict_equal?' name='create_return_correct'>
          <verdict id='create_return_correct:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>test label</exp_value>
            <act_value>test label</act_value>
          </verdict>
          <verdict id='create_return_correct:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>000000</exp_value>
            <act_value>000000</act_value>
          </verdict>
          <verdict id='create_return_correct:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
            <exp_value>false</exp_value>
            <act_value>false</act_value>
          </verdict>
          <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
            <execution duration_seconds='0.328' timestamp='2017-12-09-Sat-15.16.20.877'/>
          </ApiClient>
          <section class='Label' method='verdict_equal?' name='created_correctly'>
            <verdict id='created_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>774331363</exp_value>
              <act_value>774331363</act_value>
            </verdict>
            <verdict id='created_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</exp_value>
              <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</act_value>
            </verdict>
            <verdict id='created_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>test label</exp_value>
              <act_value>test label</act_value>
            </verdict>
            <verdict id='created_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>000000</exp_value>
              <act_value>000000</act_value>
            </verdict>
            <verdict id='created_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
              <exp_value>false</exp_value>
              <act_value>false</act_value>
            </verdict>
          </section>
          <section name='Read'>
            <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
              <execution duration_seconds='0.359' timestamp='2017-12-09-Sat-15.16.21.205'/>
            </ApiClient>
            <section class='Label' method='verdict_equal?' name='read_correctly'>
              <verdict id='read_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>774331363</exp_value>
                <act_value>774331363</act_value>
              </verdict>
              <verdict id='read_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</act_value>
              </verdict>
              <verdict id='read_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test label</exp_value>
                <act_value>test label</act_value>
              </verdict>
              <verdict id='read_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>000000</exp_value>
                <act_value>000000</act_value>
              </verdict>
              <verdict id='read_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>false</exp_value>
                <act_value>false</act_value>
              </verdict>
            </section>
            <section duration_seconds='4.462' name='Update'>
              <ApiClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
                <parameters color='ffffff'/>
                <execution duration_seconds='0.374' timestamp='2017-12-09-Sat-15.16.21.564'/>
              </ApiClient>
              <section name='Label to update'>
                <data field='id' value='774331363'/>
                <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
                <data field='name' value='test label'/>
                <data field='color' value='ffffff'/>
                <data field='default' value='false'/>
              </section>
              <section name='Label returned'>
                <data field='id' value='774331363'/>
                <data field='url' value='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'/>
                <data field='name' value='test label'/>
                <data field='color' value='ffffff'/>
                <data field='default' value='false'/>
              </section>
              <section class='Label' method='verdict_equal?' name='update_return_correct'>
                <verdict id='update_return_correct:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>774331363</exp_value>
                  <act_value>774331363</act_value>
                </verdict>
                <verdict id='update_return_correct:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</exp_value>
                  <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</act_value>
                </verdict>
                <verdict id='update_return_correct:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>test label</exp_value>
                  <act_value>test label</act_value>
                </verdict>
                <verdict id='update_return_correct:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>ffffff</exp_value>
                  <act_value>ffffff</act_value>
                </verdict>
                <verdict id='update_return_correct:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                  <exp_value>false</exp_value>
                  <act_value>false</act_value>
                </verdict>
                <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
                  <execution duration_seconds='0.374' timestamp='2017-12-09-Sat-15.16.21.938'/>
                </ApiClient>
                <section class='Label' method='verdict_equal?' name='updated_correctly'>
                  <verdict id='updated_correctly:id' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>774331363</exp_value>
                    <act_value>774331363</act_value>
                  </verdict>
                  <verdict id='updated_correctly:url' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</exp_value>
                    <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label</act_value>
                  </verdict>
                  <verdict id='updated_correctly:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>test label</exp_value>
                    <act_value>test label</act_value>
                  </verdict>
                  <verdict id='updated_correctly:color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>ffffff</exp_value>
                    <act_value>ffffff</act_value>
                  </verdict>
                  <verdict id='updated_correctly:default' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>false</exp_value>
                    <act_value>false</act_value>
                  </verdict>
                </section>
                <section name='Delete'>
                  <ApiClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
                    <execution duration_seconds='0.390' timestamp='2017-12-09-Sat-15.16.22.313'/>
                  </ApiClient>
                  <verdict id='delete_return_correct' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                    <act_value>nil</act_value>
                  </verdict>
                  <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test%20label'>
                    <execution duration_seconds='0.374' timestamp='2017-12-09-Sat-15.16.22.703'/>
                  </ApiClient>
                  <verdict id='deleted_correctly' method='verdict_refute?' outcome='passed' volatile='false'>
                    <act_value>false</act_value>
                  </verdict>
                </section>
              </section>
            </section>
            <section name='Count of errors (unexpected exceptions)'>
              <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
                <exp_value>0</exp_value>
                <act_value>0</act_value>
              </verdict>
            </section>
          </section>
        </section>
      </section>
    </section>
  </test_method>
</first_test>
```

**Prev Stop:** [Meet the Client and Log](./Meet.md#meet-the-client-and-log)

**Next Stop:** [Test Sections and Nesting](./Sections.md#test-sections-and-nesting)

