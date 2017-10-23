<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)


# PostLabels Test

## Example Test

<code>post_labels_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/post_labels'

class PostLabelsTest < BaseClassForTest

  def test_post_labels

    prelude do |client, log|

      label_created = nil
      log.section('Test PostLabels') do
        label_to_create = Label.new(
            :id => nil,
            :url => nil,
            :name => 'test_label',
            :color => '000000',
            :default => false,
        )
        Label.delete_if_exist?(client, label_to_create)
        label_created = PostLabels.verdict_call_and_verify_success(client, log, 'create label', label_to_create)
        Label.delete_if_exist?(client, label_created)

      end

    end

  end

end
```

Notes:

- This test accesses endpoint `POST /labels`, which creates a label.
- Class `PostLabels` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, the log, a verdict id, and the label to be created.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.

## Log

<code>test_post_labels.xml</code>
```xml
<post_labels_test>
  <summary errors='0' failures='0' verdicts='11'/>
  <test_method name='post_labels_test' timestamp='2017-10-22-Sun-18.09.53.793'>
    <section name='With GithubClient'>
      <section name='Test PostLabels'>
        <GithubClient duration_seconds='3.260' method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
          <execution timestamp='2017-10-22-Sun-18.09.53.809'>
            <section name='create label' timestamp='2017-10-22-Sun-18.09.55.546'>
              <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
                <parameters color='000000' name='test_label'/>
                <execution duration_seconds='0.411' timestamp='2017-10-22-Sun-18.09.55.551'/>
              </GithubClient>
              <section name='Evaluation'>
                <section name='Returned label correct'>
                  <verdict id='create label name' message='Label name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>test_label</exp_value>
                    <act_value>test_label</act_value>
                  </verdict>
                  <verdict id='create label color' message='Label color' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                    <exp_value>000000</exp_value>
                    <act_value>000000</act_value>
                  </verdict>
                </section>
                <section name='Returned label valid'>
                  <section name='verdict_assert_integer_positive?'>
                    <verdict id='create label valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                      <exp_value>Integer</exp_value>
                      <act_value>727672147</act_value>
                    </verdict>
                    <verdict id='create label valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                      <object_1>727672147</object_1>
                      <operator>:&gt;</operator>
                      <object_2>0</object_2>
                    </verdict>
                  </section>
                  <verdict id='create label valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                    <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                    <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                  </verdict>
                  <section name='verdict_assert_string_not_empty?'>
                    <verdict id='create label valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                      <exp_value>String</exp_value>
                      <act_value>test_label</act_value>
                    </verdict>
                    <verdict id='create label valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                      <act_value>test_label</act_value>
                    </verdict>
                  </section>
                  <verdict id='create label valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                    <exp_value>/[0-9a-f]{6}/i</exp_value>
                    <act_value>000000</act_value>
                  </verdict>
                  <verdict id='create label valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                    <exp_value>[TrueClass, FalseClass]</exp_value>
                    <act_value>FalseClass</act_value>
                  </verdict>
                </section>
                <section name='Label created'>
                  <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                    <execution duration_seconds='0.341' timestamp='2017-10-22-Sun-18.09.55.978'/>
                  </GithubClient>
                  <verdict id='create label exists' message='Label exists' method='verdict_assert?' outcome='passed' volatile='false'>
                    <act_value>true</act_value>
                  </verdict>
                </section>
              </section>
              <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                <execution duration_seconds='0.354' timestamp='2017-10-22-Sun-18.09.56.318'/>
              </GithubClient>
              <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
                <execution duration_seconds='0.369' timestamp='2017-10-22-Sun-18.09.56.684'/>
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
</post_labels_test>
```

Notes:

- Section `GethubClient` shows the endpoint access.
- In section `Evaluation`:
  - Section `Created label correct` verifies the created label.
  - Section `Created label valid` validates the created label.
  - Section `Created label exists` verifies that the label actually exists.

**Prev Stop:** [GetLabels Test](./GetLabels.md#getlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)
