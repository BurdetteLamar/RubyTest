<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)


# GetLabelsName Test

This is a test for endpoint `GET /labels/:name`, which fetches a label.

## Example Test

<code>get_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../endpoints/labels/get_labels_name'

class GetLabelsNameTest < BaseClassForTest

  def test_get_labels_name

    prelude do |client, log|

      log.section('Test GetLabelsName') do
        label_to_fetch = nil
        log.section('Create the label to be fetched') do
          label_to_create = Label.new(
              :id => nil,
              :url => nil,
              :name => 'test_label',
              :color => '000000',
              :default => false,
          )
          Label.delete_if_exist?(client, label_to_create)
          label_to_fetch = Label.create(client, label_to_create)
        end
        log.section('Test fetching the created label') do
          GetLabelsName.verdict_call_and_verify_success(client, 'fetch label', label_to_fetch)
        end
        log.section('Clean up') do
          Label.delete_if_exist?(client, label_to_fetch)
        end
      end

    end

  end

end
```

Notes:

- The test creates the label that it will fetch.
- It uses method `Label.delete_if_exist?` before and after, to avoid collisions and to clean up.
- Test uses the data-object method `Label.create` to create the label.
- Class `GetLabelsName` encapsulates the endpoint.
- Its method `verdict_call_and_verify_success`:
  - Accepts the client, a verdict id, and the label to be fetched.
  - Accesses the endpoint.
  - Forms the returned data into a `Label` object.
  - Performs verifications on the label object.
  - Returns the label object.

## Log

<code>test_get_labels_name.xml</code>
```xml
<get_labels_name_test>
  <summary errors='0' failures='0' verdicts='9'/>
  <test_method name='get_labels_name_test' timestamp='2017-10-23-Mon-11.46.45.299'>
    <section duration_seconds='3.287' name='With GithubClient'>
      <section name='Test GetLabelsName'>
        <section name='Create the label to be fetched'>
          <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution duration_seconds='1.757' timestamp='2017-10-23-Mon-11.46.45.302'/>
          </GithubClient>
          <GithubClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <parameters color='000000' name='test_label'/>
            <execution duration_seconds='0.362' timestamp='2017-10-23-Mon-11.46.47.066'/>
          </GithubClient>
        </section>
        <section name='Test fetching the created label'>
          <section name='fetch label' timestamp='2017-10-23-Mon-11.46.47.428'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.472' timestamp='2017-10-23-Mon-11.46.47.431'/>
            </GithubClient>
            <section name='Evaluation'>
              <verdict id='fetch label name' message='Label name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <section name='verdict_assert_integer_positive?'>
                <verdict id='fetch label valid id - integer' message='id is positive integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>Integer</exp_value>
                  <act_value>728484222</act_value>
                </verdict>
                <verdict id='fetch label valid id - positive' message='id is positive integer' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                  <object_1>728484222</object_1>
                  <operator>:&gt;</operator>
                  <object_2>0</object_2>
                </verdict>
              </section>
              <verdict id='fetch label valid url' message='url starts with' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
              </verdict>
              <section name='verdict_assert_string_not_empty?'>
                <verdict id='fetch label valid name - string' message='name is nonempty string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                  <exp_value>String</exp_value>
                  <act_value>test_label</act_value>
                </verdict>
                <verdict id='fetch label valid name - not empty' message='name is nonempty string' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                  <act_value>test_label</act_value>
                </verdict>
              </section>
              <verdict id='fetch label valid color' message='color is hex color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                <exp_value>/[0-9a-f]{6}/i</exp_value>
                <act_value>000000</act_value>
              </verdict>
              <verdict id='fetch label valid default' message='default is boolean' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                <exp_value>[TrueClass, FalseClass]</exp_value>
                <act_value>FalseClass</act_value>
              </verdict>
            </section>
          </section>
          <section name='Clean up'>
            <GithubClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.319' timestamp='2017-10-23-Mon-11.46.47.916'/>
            </GithubClient>
            <GithubClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.345' timestamp='2017-10-23-Mon-11.46.48.242'/>
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
</get_labels_name_test>
```

Notes:

- Section `GithubClient` shows the endpoint access.
- Section `Evaluation` verifies the returned label.

**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)

