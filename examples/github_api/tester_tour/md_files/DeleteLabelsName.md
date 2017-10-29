<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)


# DeleteLabelsName Test

This is a test for endpoint `DELETE /labels/:name`, which deletes a label.

## Example Test

<code>delete_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/delete_labels_name'

class DeleteLabelsNameTest < BaseClassForTest

  def test_delete_labels_name

    prelude do |client, log|

      log.section('Test DeleteLabelsName') do
        label_to_create = nil
        label_to_delete = nil
        log.section('Create the label to be deleted') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          Label.delete_if_exist?(client, label_to_create)
          label_to_delete = Label.create(client, label_to_create)
        end
        log.section('Test deleting the created label') do
          DeleteLabelsName.verdict_call_and_verify_success(client, 'delete label', label_to_delete)
        end
        log.section('Clean up') do
          Label.delete_if_exist?(client, label_to_create)
        end
      end

    end

  end

end
```

Notes:

- The test creates the label that it will delete.
- It uses method `Label.delete_if_exist?` before and after, to avoid collisions and to clean up.
- Test uses the data-object method `Label.create` to create the label.
- Class `DeleteLabelsName` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, a verdict id, and the label to be deleted.
  - Accesses the endpoint.
  - Verifies that the response is empty.
  - Verifies that the label no longer exists.

## Log

<code>test_delete_labels_name.xml</code>
```xml
<delete_labels_name_test>
  <summary errors='0' failures='0' verdicts='3'/>
  <test_method name='delete_labels_name_test' timestamp='2017-10-29-Sun-05.57.02.486'>
    <section duration_seconds='3.219' name='With GithubClient'>
      <section name='Test DeleteLabelsName'>
        <section name='Create the label to be deleted'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution duration_seconds='1.783' timestamp='2017-10-29-Sun-05.57.02.490'/>
          </GithubClient>
          <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <parameters color='000000' name='test_label'/>
            <execution duration_seconds='0.353' timestamp='2017-10-29-Sun-05.57.04.274'/>
          </GithubClient>
        </section>
        <section name='Test deleting the created label'>
          <section name='delete label' timestamp='2017-10-29-Sun-05.57.04.628'>
            <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.331' timestamp='2017-10-29-Sun-05.57.04.630'/>
            </GithubClient>
            <section name='Evaluation'>
              <section name='Response empty'>
                <verdict id='delete label payload nil' message='Payload nil' method='verdict_assert_nil?' outcome='passed' volatile='false'>
                  <act_value>nil</act_value>
                </verdict>
              </section>
              <section name='Label deleted'>
                <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                  <execution duration_seconds='0.354' timestamp='2017-10-29-Sun-05.57.04.964'/>
                </GithubClient>
                <verdict id='delete label label deleted' message='Label not exist' method='verdict_refute?' outcome='passed' volatile='false'>
                  <act_value>false</act_value>
                </verdict>
              </section>
            </section>
          </section>
          <section name='Clean up'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.387' timestamp='2017-10-29-Sun-05.57.05.318'/>
            </GithubClient>
          </section>
        </section>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>0</act_value>
      </verdict>
    </section>
  </test_method>
</delete_labels_name_test>
```

Notes:

- Section `GithubClient` shows the endpoint access.
- In section `Evaluation`:
  - Section `Response empty` verifies that the response was empty.
  - Section `Label deleted` verifies that the label no longer exists.
**Prev Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)

**Next Stop:** [More to Come ...](./MoreToCome.md#more-to-come-)

