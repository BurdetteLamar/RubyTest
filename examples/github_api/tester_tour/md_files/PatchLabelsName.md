<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)

**Next Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)


# PatchLabelsName Test

## Example Test

<code>patch_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/patch_labels_name'

class PatchLabelsNameTest < BaseClassForTest

  def test_patch_labels_name

    prelude do |client, log|

      log.section('Test PatchLabelsName') do
        label_to_create = Label.new(
            :id => nil,
            :url => nil,
            :name => 'test_label',
            :color => '000000',
            :default => false,
        )
        Label.delete_if_exist?(client, label_to_create)
        label_to_patch = Label.create(client, label_to_create)
        label_to_patch.color = 'ffffff'
        label_patched = PatchLabelsName.verdict_call_and_verify_success(client, log, 'patch label', label_to_patch)
        Label.delete_if_exist?(client, label_to_patch)
      end

    end

  end

end
```

This test a test for endpoint `PATCH /labels/:name`, which updates a label.

Notes:

- Class `PatchLabelsName` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, the log, a verdict id, and the label to be patched.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.

## Log

<code>test_patch_labels_name.xml</code>
```xml
<patch_labels_name_test>
  <summary errors='0' failures='0' verdicts='11'/>
  <test_method name='patch_labels_name_test' timestamp='2017-10-23-Mon-10.01.20.903'>
    <section duration_seconds='3.985' name='With GithubClient'>
      <section name='Test PatchLabelsName'>
        <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution duration_seconds='1.853' timestamp='2017-10-23-Mon-10.01.20.907'/>
        </GithubClient>
        <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
          <parameters color='000000' name='test_label'/>
          <execution duration_seconds='0.408' timestamp='2017-10-23-Mon-10.01.22.768'/>
        </GithubClient>
        <section name='patch label' timestamp='2017-10-23-Mon-10.01.23.176'>
          <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <parameters color='ffffff'/>
            <execution duration_seconds='0.364' timestamp='2017-10-23-Mon-10.01.23.180'/>
          </GithubClient>
          <section name='Evaluation'>
            <section name='Returned label correct'>
              <verdict id='patch label updated label-id' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>728380977</exp_value>
                <act_value>728380977</act_value>
              </verdict>
              <verdict id='patch label updated label-url' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
              </verdict>
              <verdict id='patch label updated label-name' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <verdict id='patch label updated label-color' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>ffffff</exp_value>
                <act_value>ffffff</act_value>
              </verdict>
              <verdict id='patch label updated label-default' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>false</exp_value>
                <act_value>false</act_value>
              </verdict>
            </section>
            <section name='Label updated'>
              <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                <execution duration_seconds='0.361' timestamp='2017-10-23-Mon-10.01.23.544'/>
              </GithubClient>
              <verdict id='patch label fetched label-id' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>728380977</exp_value>
                <act_value>728380977</act_value>
              </verdict>
              <verdict id='patch label fetched label-url' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
              </verdict>
              <verdict id='patch label fetched label-name' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <verdict id='patch label fetched label-color' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>ffffff</exp_value>
                <act_value>ffffff</act_value>
              </verdict>
              <verdict id='patch label fetched label-default' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>false</exp_value>
                <act_value>false</act_value>
              </verdict>
            </section>
          </section>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution duration_seconds='0.621' timestamp='2017-10-23-Mon-10.01.23.905'/>
          </GithubClient>
          <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution duration_seconds='0.362' timestamp='2017-10-23-Mon-10.01.24.526'/>
          </GithubClient>
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
</patch_labels_name_test>
```

Notes:

- In section `Evaluation`:
  - Section `Returned label correct` verifies the returned label.
  - Section `Label updated` verifies that the label was updated.

**Prev Stop:** [GetLabelsName Test](./GetLabelsName.md#getlabelsname-test)

**Next Stop:** [DeleteLabelsName Test](./DeleteLabelsName.md#deletelabelsname-test)

