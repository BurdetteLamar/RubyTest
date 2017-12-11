<!--- GENERATED FILE, DO NOT EDIT --->
**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)


# GetLabelsName Test

This is a test for endpoint `GET /labels/:name`, which fetches a label.

## Example Test

<code>get_labels_name_test.rb</code>
```ruby
require_relative '../../base_classes/base_class_for_test'

require_relative '../../api/endpoints/labels/get_labels_name'

class GetLabelsNameTest < BaseClassForTest

  def test_get_labels_name

    prelude do |log, api_client|

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
          label_to_create.delete_if_exist?(api_client)
          label_to_fetch = label_to_create.create(api_client)
        end
        log.section('Test fetching the created label') do
          GetLabelsName.verdict_call_and_verify_success(api_client, :get_label, label_to_fetch)
        end
        log.section('Clean up') do
          label_to_fetch.delete_if_exist?(api_client)
        end
      end

    end

  end

end
```

Notes:

- The test creates the label that it will fetch.
- It uses method `Label#delete_if_exist?` before and after, to avoid collisions and to clean up.
- Test uses the data-object method `Label#create` to create the label.
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
  <test_method name='get_labels_name_test' timestamp='2017-12-11-Mon-15.04.41.068'>
    <section duration_seconds='3.276' name='Test'>
      <section name='Test GetLabelsName'>
        <section name='Create the label to be fetched'>
          <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
            <execution duration_seconds='1.732' timestamp='2017-12-11-Mon-15.04.41.068'/>
          </ApiClient>
          <ApiClient method='POST' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels'>
            <parameters color='000000' name='test_label'/>
            <execution duration_seconds='0.359' timestamp='2017-12-11-Mon-15.04.42.800'/>
          </ApiClient>
        </section>
        <section name='Test fetching the created label'>
          <section name='get_label' timestamp='2017-12-11-Mon-15.04.43.159'>
            <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.328' timestamp='2017-12-11-Mon-15.04.43.159'/>
            </ApiClient>
            <section name='Evaluation'>
              <verdict id='get_label:name' method='verdict_assert_equal?' outcome='passed' volatile='false'>
                <exp_value>test_label</exp_value>
                <act_value>test_label</act_value>
              </verdict>
              <section class='Label' method='verdict_valid?' name='valid'>
                <section name='verdict_assert_integer_positive?'>
                  <verdict id='get_label:valid:id:integer' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                    <exp_value>Integer</exp_value>
                    <act_value>775993487</act_value>
                  </verdict>
                  <verdict id='get_label:valid:id:positive' method='verdict_assert_operator?' outcome='passed' volatile='false'>
                    <object_1>775993487</object_1>
                    <operator>:&gt;</operator>
                    <object_2>0</object_2>
                  </verdict>
                </section>
                <verdict id='get_label:valid:url' method='verdict_assert_match?' outcome='passed' volatile='false'>
                  <exp_value>/^https:\/\/api.github.com\/repos/</exp_value>
                  <act_value>https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label</act_value>
                </verdict>
                <section name='verdict_assert_string_not_empty?'>
                  <verdict id='get_label:valid:name:string' method='verdict_assert_kind_of?' outcome='passed' volatile='false'>
                    <exp_value>String</exp_value>
                    <act_value>test_label</act_value>
                  </verdict>
                  <verdict id='get_label:valid:name:not_empty' method='verdict_refute_empty?' outcome='passed' volatile='false'>
                    <act_value>test_label</act_value>
                  </verdict>
                </section>
                <verdict id='get_label:valid:color' method='verdict_assert_match?' outcome='passed' volatile='false'>
                  <exp_value>/[0-9a-f]{6}/i</exp_value>
                  <act_value>000000</act_value>
                </verdict>
                <verdict id='get_label:valid:default' method='verdict_assert_includes?' outcome='passed' volatile='false'>
                  <exp_value>[TrueClass, FalseClass]</exp_value>
                  <act_value>FalseClass</act_value>
                </verdict>
              </section>
            </section>
          </section>
          <section name='Clean up'>
            <ApiClient method='GET' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.468' timestamp='2017-12-11-Mon-15.04.43.502'/>
            </ApiClient>
            <ApiClient method='DELETE' url='https://api.github.com/repos/BurdetteLamar/CrashDummy/labels/test_label'>
              <execution duration_seconds='0.374' timestamp='2017-12-11-Mon-15.04.43.970'/>
            </ApiClient>
          </section>
        </section>
      </section>
    </section>
    <section name='Count of errors (unexpected exceptions)'>
      <verdict id='error_count' method='verdict_assert_equal?' outcome='passed' volatile='true'>
        <exp_value>0</exp_value>
        <act_value>0</act_value>
      </verdict>
    </section>
  </test_method>
</get_labels_name_test>
```

Notes:

- Section `ApiClient` shows the endpoint access.
- Section `Evaluation` verifies the returned label.

**Prev Stop:** [PostLabels Test](./PostLabels.md#postlabels-test)

**Next Stop:** [PatchLabelsName Test](./PatchLabelsName.md#patchlabelsname-test)

