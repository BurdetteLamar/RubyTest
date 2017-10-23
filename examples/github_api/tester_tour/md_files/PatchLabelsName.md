<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)


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
        {
            :color => 'ffffff',
        }.each_pair do |name, value|
          method = "#{name}="
          label_to_patch.send(method, value)
        end
        label_patched = PatchLabelsName.verdict_call_and_verify_success(client, log, 'patch label', label_to_patch)
        Label.delete_if_exist?(client, label_patched)
      end

    end

  end

end
```

Notes:

- This test accesses endpoint `PATCH /labels/:name`, which updates a label.
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
  <summary errors='0' failures='0' verdicts='18'/>
  <test_method name='patch_labels_name_test' timestamp='2017-10-22-Sun-18.09.58.137'>
    <section name='With GithubClient'>
      <section name='Test PatchLabelsName'>
        <GithubClient duration_seconds='3.526' method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution timestamp='2017-10-22-Sun-18.09.58.142'>
            <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
              <parameters color='000000' name='test_label'/>
              <execution duration_seconds='0.361' timestamp='2017-10-22-Sun-18.09.59.909'/>
            </GithubClient>
            <section name='patch label' timestamp='2017-10-22-Sun-18.10.00.270'>
              <GithubClient method='PATCH' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                <parameters color='ffffff'/>
                <execution duration_seconds='0.353' timestamp='2017-10-22-Sun-18.10.00.270'/>
              </GithubClient>
              <section name='Evaluation'>
                <section name='Updated label correct'>
                  <verdict id='patch label updated label-id' message='Updated label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>727672156</exp_value>
                    <act_value>727672156</act_value>
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
                <section name='Returned label valid'>
                  <section name='verdict_assert_integer_positive?'>
                    <verdict id='patch label returned label id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                      <exp_value>Integer</exp_value>
                      <act_value>727672156</act_value>
                    </verdict>
                    <verdict id='patch label returned label id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                      <object_1>727672156</object_1>
                      <operator>:&gt;</operator>
                      <object_2>0</object_2>
                    </verdict>
                  </section>
                  <verdict id='patch label returned label url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                    <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                    <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                  </verdict>
                  <section name='verdict_assert_string_not_empty?'>
                    <verdict id='patch label returned label name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                      <exp_value>String</exp_value>
                      <act_value>test_label</act_value>
                    </verdict>
                    <verdict id='patch label returned label name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                      <act_value>test_label</act_value>
                    </verdict>
                  </section>
                  <verdict id='patch label returned label color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                    <exp_value>/[0-9a-f]{6}/i</exp_value>
                    <act_value>ffffff</act_value>
                  </verdict>
                  <verdict id='patch label returned label default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                    <exp_value>[TrueClass, FalseClass]</exp_value>
                    <act_value>FalseClass</act_value>
                  </verdict>
                </section>
                <section name='Label updated'>
                  <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                    <execution duration_seconds='0.327' timestamp='2017-10-22-Sun-18.10.00.640'/>
                  </GithubClient>
                  <verdict id='patch label fetched label-id' message='Fetched label correct' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>727672156</exp_value>
                    <act_value>727672156</act_value>
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
                <execution duration_seconds='0.341' timestamp='2017-10-22-Sun-18.10.00.966'/>
              </GithubClient>
              <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                <execution duration_seconds='0.356' timestamp='2017-10-22-Sun-18.10.01.307'/>
              </GithubClient>
            </section>
          </execution>
        </GithubClient>
        <section name='Count of errors (unexpected exceptions)'>
          <verdict id='error count' message='error count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
            <exp_value>0</exp_value>
            <act_value>0</act_value>
          </verdict>
        </section>
      </section>
    </section>
  </test_method>
</patch_labels_name_test>
```

Notes:

- Section `GethubClient` shows the endpoint access.
- Section `Info` shows:
  - The count of labels.
  - The first label.
- Section 'Evaluation' shows validations for the first label.

**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

